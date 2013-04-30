window.app.services.Share = {
  record_tweet : function(share) {
    return $.post(
      "/shares",
      {
        share: {
          campaign_id: share.campaign_id,
          share_method: 'twitter',
          testimonial: share.testimonial
        }
      },
      function(data, textStatus, jqXHR){
        console.info("tweet recorded", textStatus, data, jqXHR);
      }
    );
  }
};
