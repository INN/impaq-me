window.app.services.Share = {
  record_tweet : function(campaign_id, testimonial) {
    return $.post(
      "/shares",
      {
        share: {
          campaign_id: campaign_id,
          share_method: 'twitter',
          testimonial: testimonial
        }
      },
      function(data, textStatus, jqXHR){
        console.info("tweet recorded", textStatus, data, jqXHR);
      }
    );
  }
};
