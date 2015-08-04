Hastings::Script.new do
  title "Source file backup"
  description "My source file description"
  run_every 4.hours
  start_at "2015-06-25 16:23"

  run do
    input  =  dir "//from_share/foo/bar"
    output = dir "//to_share/foo/bar"

    loop input.files do |f|
      f.move_to(output)
      log "Moving " + f + " to " + output
    end
  end
end
