class Datafile < ActiveRecord::Base
  attr_accessor :upload
  def self.save(upload)
    #file_name = upload['datafile'].original_filename
    #file = upload['datafile'].read

    #image_root = "/data/"

    #Dir.mkdir(image_root + "#{file_name}");
    #File.open(image_root + "#{file_name}/", "wb")  do |f|
      #f.write(file)
    #end

    name = upload['datafile'].original_filename
    File.open(Rails.root.join('public', 'data', name), 'wb') do |file|
      file.write(upload['datafile'].read)
    end
  end
end