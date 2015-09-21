class ProductPictureUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.jpg"].compact.join('_'))
  end

  process resize_to_fit: [420, 420]

  version :thumb do
    process resize_to_fit: [190, 190]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  def filename
    if original_filename.present?
      if model && model.read_attribute(mounted_as).present?
        model.read_attribute(mounted_as)
      else
        "#{secure_token}.#{file.extension}"
      end
    end
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
  
end

