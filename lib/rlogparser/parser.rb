class Parser
  def initialize(fd, options)
    @fd = fd
    @opts = options
  end
  
  def read
    @fd.each do |line|
      block = get_block(line)
      items = parse_block(block)
    end
  end
  
  def get_block(line)
    block = []
    while line !~ /^Processing/
      line = @fd.gets
    end
    return nil if @fd.eof
    
    block << line
    line = @fd.gets
    while line !~ /^Completed in/
      line = @fd.gets
      block << line
    end
    return nil if @fd.eof
    
    return block
  end
  
  def parse_block(blk)
    puts "Block: #{blk.inspect}"
  end
  
end