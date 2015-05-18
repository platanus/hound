class DefaultConfigFile
  CONFIG_DIR = "config/style_guides"
  THOUGHTBOT_CONFIG_DIR = "config/style_guides/thoughtbot"
  PLATANUS_CONFIG_DIR = "config/style_guides/platanus"

  pattr_initialize :file_name, :repository_owner_name

  def path
    File.join(directory, file_name)
  end

  private

  def directory
    if thoughtbot_repository?
      THOUGHTBOT_CONFIG_DIR
    elsif platanus_repository?
      PLATANUS_CONFIG_DIR
    else
      CONFIG_DIR
    end
  end

  def thoughtbot_repository?
    repository_owner_name == "thoughtbot"
  end

  def platanus_repository?
    repository_owner_name == "platanus"
  end
end
