module SimpleNestedComments
  class Engine < ::Rails::Engine
    #isolate_namespace SimpleNestedComments -- Removed this so we can call the helper methods

    # To get localization to load, per: http://stackoverflow.com/questions/23986512/app-cannot-access-translation-files-in-engine-or-gem
    config.before_initialize do
      config.i18n.load_path += Dir["#{config.root}/config/locales/**/*.yml"]
    end
  end
end
