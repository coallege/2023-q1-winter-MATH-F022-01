words_txt = open("words.txt", "r")
words_h = open("words.h", "w")

word_count = 0
words_h.write("char const words[][6] = {\n")

for word in words_txt:
   word = word.strip()
   words_h.write(f'   "{word}",\n')
   word_count += 1

words_h.write("};\n\n")
words_h.write(f"size_t word_count = {word_count};\n")
