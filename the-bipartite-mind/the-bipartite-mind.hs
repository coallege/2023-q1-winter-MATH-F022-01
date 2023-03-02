{-# LANGUAGE BlockArguments #-}
module Main(main) where
import qualified Data.Set as Set

parseEntry :: String -> Maybe (String, String)
parseEntry s =
   let words' = words s in
      if (length words') == 2
         then Just (head words', head $ tail words')
         else Nothing

takeLines :: IO [(String, String)]
takeLines = do
   line <- getLine
   if line == "done"
      then return []
      else do
         let parsed = parseEntry line
         case parsed of
            Nothing -> do
               putStrLn "Could not understand that input!"
               takeLines
            Just iceForAll -> do
               rest <- takeLines
               return $ iceForAll : rest

twonarySort :: [(String, String)] -> IO Bool
twonarySort entireList = let
   recursiveSort leftSide rightSide lst =
      if null lst
         then return True
         else let
               (a, b) = head lst
               rest   = tail lst
               aleft  = Set.member a leftSide
               bleft  = Set.member b leftSide
               aright = Set.member a rightSide
               bright = Set.member b rightSide
            in if aleft && bleft
               then do
                  putStrLn $ a ++ " was sorted left but it is paired with " ++ b ++ " which was also sorted left."
                  return False
               else if aright && bright
                  then do
                     putStrLn $ a ++ " was sorted right but it is paired with " ++ b ++ " which was also sorted right."
                     return False
                  else if (aright || bleft)
                     then recursiveSort (Set.insert b leftSide) (Set.insert a rightSide) rest
                     else recursiveSort (Set.insert a leftSide) (Set.insert b rightSide) rest
   in recursiveSort Set.empty Set.empty entireList

main :: IO ()
main = do
   putStr "Enter an adjacency list with one entry per line separated by spaces:\nType 'done' when you're finished.\n"
   pairs <- takeLines
   bipartite <- twonarySort pairs
   putStrLn $ "The graph " ++ (if bipartite then "was" else "was not") ++ " bipartite."
