Before do
  $driver = Rufus::Driver.new if $driver.nil?
  sleep 2
  $driver.start
end

After do
  `rm coolShot.png` if File.exists? 'coolShot.png'
  $driver = nil
  sleep 2
end