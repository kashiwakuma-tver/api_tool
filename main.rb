require_relative 'lib/api/video_cloud'
require_relative 'lib/api/tvercms/episode'
require_relative 'lib/api/tvercms/series'
require_relative 'lib/api/tvercms/season'
require_relative 'lib/api/tvercms/vod'
require_relative 'lib/api/tvercms/api_base'
require_relative 'lib/api/contentmaster/contentmaster'
require_relative 'lib/api/base'

Episode.new.episode_vods
# Episode.new.episode_vod
# Episode.new.episode_lives
# Episode.new.episode_live

# Series.new.serieses
# Series.new.series

# Season.new.series_seasons('sr30gynbcab')
# Season.new.series_season('sr30gynbcab')
# Season.new.season

# Vod.new.vod

# c = ContentMaster.new
# c.exec_api