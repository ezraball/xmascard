class Card < ActiveRecord::Base
  attr_accessible :address, :message, :name, :frontimg, :backimg, :frontimg_file_name, :frontimg_content_type, :frontimg_file_size, :frontimg_updated_at, :backimg_file_name, :backimg_content_type, :backimg_file_size, :backimg_updated_at
  
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
  
  def self.load_dir_of_images(dirname)
    startdir = Dir.pwd
    Dir.chdir(dirname)
    Dir.glob("**/*Front.{jpg,jpeg}") do |filename|
      f = File.new(filename)
      Card.create_from_frontimg(f)
      f.close
    end
    Dir.chdir(startdir)
  end
  
  def self.create_from_frontimg(frontfile)
    c = Card.create(:name => guess_name(frontfile.path))
    c.frontimg = frontfile
    if bf = get_backimg(frontfile)
      c.backimg = bf
      bf.close
    end
    c.save
    c
  end
  
  def push_to_remote
    rc = RemoteCard.new
    self.attributes.each_pair do |key,value|
      rc.send("#{key}=",value)
    end
    rc.save
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
