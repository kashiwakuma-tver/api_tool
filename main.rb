require_relative 'lib/api/video_cloud'
require_relative 'lib/api/tvercms/episode'

e = Episode.new
e.exec_vod_episode_api

# vc = VideoCloud.new
# print vc.exec

