class MyHeywatchController < ApplicationController

  def upload_complete
    debug_print
    puts "u"*70
    puts "upload_complete params below"
    puts params
    #binding.pry
     encode params[:id], params['id']
  end

  def encode id, video_id
    hw = HeyWatch.new
     hw.create :job, {
      :video_id =>  video_id, 
      format_id: "mp4_480p", 
      :output_url => "s3://#{ENV['AMAZON_ID']}:#{ENV['AMAZON_KEY']}@videosok/converted/abcd.mp4", 
      ping_url: "easyvid.com/hw/encoded/#{id}"
    }
    #binding.pry
  end

  def encode_complete
    debug_print
    puts "e"*70
    puts "encode_complete params below"
    puts params
    video = Video.find(params[:id])
    video.url = params[:response]
    video.processed = "processed"
    video.save
    #redirect user with gone
  end
end
