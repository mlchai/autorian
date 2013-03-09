class RianConfig
  HEADERS =
    'video_id,username,time_uploaded,title,length,view_count,comment_count,status,category,favorite_count,embedding_allowed,ratings_allowed,responses_allowed,comments_allowed,is_licensed,offweb_syndicatable,in_video_ads_enabled,claim_source,claimed_by_this_owner,claimed_by_another_owner,claim_id,asset_id,claim_custom_id,policy,third_party_ads_enabled,afv_overlay_enabled,instream_ads_enabled,long_instream_enabled,trueview_instream_enabled,trueview_inslate_enabled,prerolls_enabled,midrolls_enabled,postrolls_enabled,isrc'

  DATA_TYPES =
    'integer,varchar,date,varchar,integer,integer,integer,varchar,varchar,integer,boolean,boolean,boolean,boolean,boolean,boolean,boolean,varchar,boolean,boolean,varchar,varchar,varchar,varchar,boolean,boolean,boolean,boolean,boolean,boolean,boolean,boolean,boolean,varchar'

  DATABASE = {name: 'autorian.db', user: '', password: ''}
end