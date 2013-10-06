Before do
  $driver = Rufus::Driver.new if $driver.nil?
  sleep 2
  $driver.start
end

After do
  $driver = nil
  sleep 2
end