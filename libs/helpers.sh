execute_in_chroot() {
  local path="$1"
  local command="$2"

  if [[ -d "$path" ]]; then
    echo "Entering chroot at $path to execute command: $command"
    
    # Use chroot to change the root directory and execute the command
    chroot "$path" /bin/sh -c "$command"
  else
    echo "Error: $path is not a valid directory"
  fi
}
check_files_in_directory() {
  local file_list="$1"
  local directory="$2"

  while IFS= read -r line
  do
    local full_path="$directory/$line"

    if [[ -e "$full_path" ]]; then
      : # Do nothing
    else
      echo "File $full_path does not exist."
    fi
  done < "$file_list"
}
