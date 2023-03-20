#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include "words.h"

enum score {
   grey   = 0,
   yellow = 1,
   green  = 2,
};

unsigned char typedef byte;
enum score typedef score;

__attribute__((sysv_abi))
score letter_score(char const answer[6], char const guess[6], size_t letter_idx) {
   char const guess_letter = guess[letter_idx];

   if (guess_letter == answer[letter_idx]) {
      return green;
   }

   for (size_t i = 0; i < 5; i++) {
      if (guess_letter == answer[i]) {
         return yellow;
      }
   }

   return grey;
}

_Bool responses[243] = {0};
void start(void) {
   for (size_t answer_idx = 0; answer_idx < word_count; answer_idx++) {
      char const *answer = words[answer_idx];
      for (size_t guess_idx = 0; guess_idx < word_count; guess_idx++) {
         char const *guess = words[guess_idx];
         // max is 22222_3 which is 242 in decimal
         byte word_score = 0;
         for (size_t letter_idx = 0, multiplier = 1; letter_idx < 5; letter_idx++, multiplier *= 3) {
            word_score += letter_score(answer, guess, letter_idx) * multiplier;
         }
         responses[word_score] = 1;
      }
   }

   byte response_count = 0;
   for (size_t i = 0; i < sizeof(responses); i++) {
      if (responses[i]) {
         response_count++;
      }
   }

   char result[] = "000\n";
   result[0] += response_count / 100;
   result[1] += (response_count % 100) / 10;
   result[2] += response_count % 10;

   WriteFile(GetStdHandle(STD_OUTPUT_HANDLE), result, sizeof(result), NULL, NULL);
   ExitProcess(0);
}
