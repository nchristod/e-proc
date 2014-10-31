# You'll need to pregenerate a keyring with your pubkey in it and add to your repo.
# GPG does this automatically when you import keys to a non-existant keyring file.
 
module Paperclip
  class Encrypt < Processor
    def make
      raise ArgumentError.new("no :encrypt_to address provided. (#{@options.inspect})") unless @options[:encrypt_to]
       
      Tempfile.new(['attachment','.pgp']).tap do |outfile|
        Paperclip.run('gpg', '--batch --always-trust --keyring :keyring --no-default-keyring -o :out -r :recipient -e :in', :in => @file.path, :out => outfile.path, :recipient => @options[:encrypt_to], :keyring => PATH_TO_MY_KEYRING)
      end
    end
  end
end