function ex --description 'extract files with one command'

  switch $argv
      case *.tar*
          tar -xf $argv && rm $argv
      
      case *.tgz*
          tar xzf $argv && rm $argv
          
      case *.zip*
          unzip $argv && rm $argv
          
      case *
          echo "File cannot be extracted via ex"
      
      end

end
