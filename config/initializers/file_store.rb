module ActiveSupport
  module Cache
    class FileStore < Store
      private
        # Patch this so we don't have long paths
        def key_file_path(key)
          fname = URI.encode_www_form_component(key)
          hash = Zlib.adler32(fname)
          hash, dir_1 = hash.divmod(0x1000)
          dir_2 = hash.modulo(0x1000)
          fname_paths = []

          # Make sure file name doesn't exceed file system limits.
          begin
            fname_paths << fname[0, FILENAME_MAX_SIZE]
            fname = fname[FILENAME_MAX_SIZE..-1]
          end until fname.blank?

          key = Digest::MD5.hexdigest(fname_paths.join())
          File.join(cache_path, DIR_FORMATTER % dir_1, DIR_FORMATTER % dir_2, key)
        end
     end
  end
end