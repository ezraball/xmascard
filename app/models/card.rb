class String
  def is_year?
    self.match(/^[12][0-9]{3}$/)
  end
end

class Card < ActiveRecord::Base
  attr_accessible :address, :message, :name, :frontimg, :backimg, :frontimg_file_name, :frontimg_content_type, :frontimg_file_size, :frontimg_updated_at, :backimg_file_name, :backimg_content_type, :backimg_file_size, :backimg_updated_at, :original_filename, :year_list, :tag_list
  attr_reader :DEFAULT_IMAGE_FOLDER
  
  has_attached_file :frontimg, 
    :styles => { :full => "600x600>", :medium => "300x300>", :thumb => "100x100>" },
    :storage => :s3,
    :path => "/frontimg/:style/:filename",
    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml"
  
  has_attached_file :backimg, 
    :styles => { :full => "600x600>", :medium => "300x300>", :thumb => "100x100>" },
    :storage => :s3,
    :path => "/backimg/:style/:filename",
    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml"
  DEFAULT_IMAGE_FOLDER = "/Users/ezraball/Documents/xmas_postcard_pics"
  
  acts_as_taggable_on :years, :tags
  
  validates :frontimg, :attachment_presence => true
  before_create :set_fingerprint
  before_save :set_name_if_blank
  
  
  def self.load_dir_of_images(dirname)
    startdir = Dir.pwd
    Dir.chdir(dirname)
    find_front_images.each do |filename|
      c = Card.find_by_original_filename(filename)
      unless c
        Card.create_from_frontimg(filename) 
      end
    end
    Dir.chdir(startdir)
  end
    
  def self.create_from_frontimg(filename)
    f = File.new(filename)
    c = Card.create(:frontimg => f, :original_filename => filename)
    c.tag_from_original_filename
    if bf = get_backimg(f)
      c.backimg = bf
      bf.close
    end
    c.save
    c
    f.close
  end
  
  def tag_from_original_filename
    if self.original_filename
      tags = self.original_filename.split("/")[0..-2]
      self.year_list = (self.year_list + tags.select{|t| t.is_year?}).flatten.join(",")
      self.tag_list = (self.tag_list + tags.reject{|t| t.is_year?}).flatten.join(",")
    end
  end
  
  def push_to_remote
    rc = RemoteCard.new
    self.attributes.each_pair do |key,value|
      rc.send("#{key}=",value)
    end
    rc.save
  end
  
  def set_name_if_blank
    (self.name = Card.guess_name(self.frontimg_file_name)) if self.name.blank?
  end
  
  def set_fingerprint    
    self.fingerprint = make_fingerprint
  end
  
  def self.find_front_images
    Dir.glob("**/*Front.{jpg,jpeg}")
  end
  def make_fingerprint
    "#{frontimg_file_size}-#{name}"
  end

  private
  
  def self.get_backimg(frontfile)
    fname = guess_backimg_name(frontfile.path)
    if fname != frontfile.path && File.exists?(fname)
      File.new(fname)
    end
  end
  
  def self.guess_backimg_name(frontimg_name)
    frontimg_name.gsub('Front','Back')
  end
  
  def self.guess_name(frontimg_name)
    frontimg_name.split("/").last.gsub("_Front",'').gsub('Back','').gsub('_',' ').gsub('.jpg','').gsub('.jpeg','').titlecase
  end
    
end
