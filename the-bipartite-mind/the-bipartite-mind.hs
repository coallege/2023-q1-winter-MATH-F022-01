{-# LANGUAGE BlockArguments #-}
module Main(main) where

parseEntry :: String -> Maybe (String, String)
parseEntry s =
   let words' = words s in
      if (length words') == 2
         then Just (head words', head $ tail words')
         else Nothing

data Side = LeftSide | RightSide

main :: IO()
main = do
   putStr "Enter an adjacency list with one entry per line separated by spaces:\nType 'done' when you're finished.\n"
   let
      takeLine = do
         line <- getLine
         if line == "done"
            then return []
            else do
               let parsed = parseEntry line
               case parsed of
                  Nothing -> do
                     putStrLn "Could not understand that input!"
                     takeLine
                  Just iceForAll -> do
                     rest <- takeLine
                     return $ iceForAll : rest
   pairs <- takeLine
   return ()
