class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    new_song =  self.new.tap do |song|
      self.all << song
    end
  end

  def self.new_by_name(name)
    new_song = self.new.tap do |song|
      song.name = name
    end
  end

  def self.create_by_name(name)
    new_song = self.create.tap do |song|
      song.name = name
    end
  end

  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : self.create_by_name(name)
  end

  def self.alphabetical
    self.all.sort_by {|song| song.name}
  end

  def self.split_file_name(filename)
    split_data = filename.split(/[-.]/)
    file_info = {
      song_name: split_data[1].strip,
      artist_name: split_data[0].strip
    }
  end

  def self.new_from_filename(filename)
    new_song = self.new.tap do |song|
      song.name = self.split_file_name(filename)[:song_name]
      song.artist_name = self.split_file_name(filename)[:artist_name]
    end
  end

  def self.create_from_filename(filename)
    new_song = self.create_by_name(self.split_file_name(filename)[:song_name])
    new_song.artist_name = self.split_file_name(filename)[:artist_name]
  end

  def self.destroy_all
    self.all.clear
  end

end
