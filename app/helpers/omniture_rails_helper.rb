module OmnitureRailsHelper
  def omniture_html
    <<-EOS
    <!-- SiteCatalyst code version: H.1. Copyright 1997-2005 Omniture, Inc. More info available at http://www.omniture.com -->
    <script language="JavaScript"><!--
      #{omniture_javascript}
      //--></script>
      <script language="JavaScript"><!--
      if(navigator.appVersion.indexOf('MSIE')>=0)document.write(unescape('%3C')+'\!-'+'-')
      //--></script><noscript><img
      src="#{OmnitureRails.config.noscript_img_src}"
      height="1" width="1" border="0" alt="" /></noscript><!--/DO NOT REMOVE/-->
      <!-- End SiteCatalyst code version: H.1. -->
    EOS
  end
  
  def omniture_javascript
    <<-EOS
    var s_account="#{OmnitureRails.config.tracking_account}";
    var s=s_gi(s_account);

    $.extend(s, #{sprops})

    /* WARNING: Changing the visitor namespace will cause drastic changes
    to how your visitor data is collected.  Changes should only be made
    when instructed to do so by your account manager.*/
    s.visitorNamespace="#{OmnitureRails.config.visitor_namespace}"

    /************* DO NOT ALTER ANYTHING BELOW THIS LINE ! **************/
    var s_code=s.t();if(s_code)document.write(s_code)
    EOS
  end
  
  def sprops
    OmnitureRails.
      values_for(omniture_input, OmnitureRails::TREES[controller_name.to_sym], {}, self).
      delete_if{|k,v| !v}.
      to_json.
      gsub(/,\s*"/,",\n\"") #put each variable on a separate line
  end
end