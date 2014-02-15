Before do
  $rufus = Rufus::Driver.new #if $rufus.nil?
end

After do
  `rm coolShot.png` if File.exists? 'coolShot.png'
  $rufus = nil
end