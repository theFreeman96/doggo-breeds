String capitalizeString(String inputString, String wordSplitter) {
  return inputString.split(wordSplitter).map((word) {
    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');
}
