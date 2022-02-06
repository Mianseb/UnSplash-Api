class Config{


  static const topicUrl = 'https://api.unsplash.com/topics/?client_id=QaNbFqf2YRAuywulDDCz6FpOMKiw8uhTyIOk3gdh6Jk&per_page=20';
  static String getPhotos(String photoUrl)
  {
         return photoUrl + '?client_id=QaNbFqf2YRAuywulDDCz6FpOMKiw8uhTyIOk3gdh6Jk&per_page=30';
  }
}