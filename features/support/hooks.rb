Before do
  $rufus = Rufus::Driver.new #if $rufus.nil?
  #sleep 2
  #$driver.start
end

After do
  `rm coolShot.png` if File.exists? 'coolShot.png'
  $rufus = nil
  sleep 2
end