<xsl:stylesheet version="1.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:aas="http://dca.tufts.edu/aas"
   exclude-result-prefixes="aas">

  <xsl:output method="xml" indent="no"
              doctype-public="-//W3C//DTD XHTML 1.1//EN"
              doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
              encoding="US-ASCII" />

  <xsl:key name="candidate-key" match="//aas:candidate" use="@candidate_num"/>
  
  <xsl:template match="/aas:election_record">

      <xsl:apply-templates/>

      <!-- FOOTNOTES -->
      <xsl:call-template name="footnotes"/>

      <!-- REFERENCES -->
      <xsl:call-template name="references"/>

      <!-- PAGE IMAGES -->
      <xsl:call-template name="page-images"/>

  </xsl:template>

  <xsl:template match="aas:role">

     <!-- The main presentation of results -->
     <div id="election-results">
       <table class="election-results-table">

       <thead>
         <tr class="candidate-row">
           <td>Candidates <xsl:apply-templates select="/aas:election_record/aas:office/aas:role/aas:ballot/aas:note"/></td>
           <xsl:for-each select="/aas:election_record/aas:office/aas:role/aas:ballot/aas:candidate">
             <xsl:sort select="@candidate_num" data-type="number" order="ascending"/>
             <xsl:variable name="cand_id" select="@candidate_num"/>

             <td><xsl:value-of select="@name"/></td>
           </xsl:for-each>
         </tr>

         <tr class="affiliation-row"><td/>
           <xsl:for-each select="/aas:election_record/aas:office/aas:role/aas:ballot/aas:candidate">
             <xsl:sort select="@candidate_num" data-type="number" order="ascending"/>
             <xsl:variable name="cand_id" select="@candidate_num"/>

             <td>
               <xsl:choose>
           <xsl:when test="@affiliation = 'null'"></xsl:when>
           <xsl:otherwise><xsl:value-of select="@affiliation"/></xsl:otherwise>
               </xsl:choose>
             </td>
           </xsl:for-each>
         </tr>	 


         <tr class="overview-row">
           <td>Final Result <xsl:apply-templates select="/aas:election_record/aas:office/aas:role/aas:overview/aas:note"/></td>
           <xsl:for-each select="/aas:election_record/aas:office/aas:role/aas:ballot/aas:candidate">
             <xsl:sort select="@candidate_num" data-type="number" order="ascending"/>
             <xsl:variable name="cand_id" select="@candidate_num"/>
             
             <xsl:variable name="x">
               <xsl:value-of select="/aas:election_record/aas:office/aas:role/aas:overview/aas:candidate_summary[@candidate_ref=$cand_id]/@vote_total"/>
             </xsl:variable>
             
             <xsl:choose>
               <xsl:when test="normalize-space($x)=''"><td class="vote-nodata">-</td></xsl:when>
               <xsl:otherwise><td class="vote"><xsl:value-of select="$x"/></td></xsl:otherwise>
             </xsl:choose>

           </xsl:for-each>
         </tr>
       </thead>

	 <xsl:apply-templates select="aas:admin_unit"/>

       </table>
     </div>
  </xsl:template>
  
  <xsl:template match="aas:sub_unit">
    <xsl:variable name="sub_unit" select="."/>
    <xsl:variable name="depth">
      <xsl:call-template name="sub_unit_depth"/>
    </xsl:variable>

<!--
    <xsl:choose>
      <xsl:when test="$depth = 0">
	 <xsl:call-template name="spacer"><xsl:with-param name="sp-class" select="'major-spacer-row'"/></xsl:call-template>
	 <xsl:call-template name="spacer"><xsl:with-param name="sp-class" select="'clear-spacer-row'"/></xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	 <xsl:call-template name="spacer"><xsl:with-param name="sp-class" select="'minor-spacer-row'"/></xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
-->

    <tr class="sub-unit-row{$depth}">
      <td class="sub-unit-{@type}">
	<xsl:call-template name="unit_name">
	  <xsl:with-param name="name" select="@name"/>
	  <xsl:with-param name="type" select="@type"/>
	  <xsl:with-param name="depth" select="$depth"/>
	</xsl:call-template>
	<xsl:apply-templates select="aas:note"/>
      </td>

      <xsl:for-each select="/aas:election_record/aas:office/aas:role/aas:ballot/aas:candidate">
	<xsl:sort select="@candidate_num" data-type="number" order="ascending"/>
	<xsl:variable name="cand_id" select="@candidate_num"/>
	     
	<xsl:variable name="x">
	  <xsl:value-of select="$sub_unit/aas:result[@candidate_ref=$cand_id]/@vote"/>
	</xsl:variable>
	     
	<xsl:choose>
	  <xsl:when test="normalize-space($x)=''"><td class="vote-nodata">-</td></xsl:when>
	  <xsl:otherwise><td class="vote"><xsl:value-of select="$x"/></td></xsl:otherwise>
	</xsl:choose>
	
      </xsl:for-each>
    </tr>

    <xsl:apply-templates select="aas:sub_unit"/>

    <xsl:if test="$depth = 0">
      <xsl:call-template name="spacer"><xsl:with-param name="sp-class" select="'clear-spacer-row'"/></xsl:call-template>	
    </xsl:if>

  </xsl:template>

  <xsl:template name="election_title">
    <xsl:variable name="scope"><xsl:value-of select="/aas:election_record/aas:office/aas:role/@scope"/></xsl:variable>

    <xsl:choose>
      <xsl:when test="//aas:sub_unit[@type = $scope]">
	<xsl:call-template name="unit_name">
	  <xsl:with-param name="name" select="//aas:sub_unit[@type = $scope]/@name"/>
	  <xsl:with-param name="type" select="$scope"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:call-template name="unit_name">
	  <xsl:with-param name="name" select="/aas:election_record/aas:office/aas:role/aas:admin_unit/@name"/>
	  <xsl:with-param name="type" select="/aas:election_record/aas:office/aas:role/aas:admin_unit/@type"/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:text> </xsl:text>
    <xsl:value-of select="/aas:election_record/@date"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="/aas:election_record/@type"/>
    <xsl:text> Election for </xsl:text>
    <xsl:value-of select="/aas:election_record/aas:office/aas:role/@title"/>
    <xsl:if test="/aas:election_record/@iteration != '' and /aas:election_record/@iteration != 'null' and /aas:election_record/@iteration != 'First Ballot'">
      <xsl:text> : </xsl:text>
      <xsl:value-of select="/aas:election_record/@iteration"/>
    </xsl:if>
  </xsl:template>


  <xsl:template name="unit_name">
    <xsl:param name="name"/>
    <xsl:param name="type"/>
    <xsl:param name="depth" select="0"/>

    <xsl:choose>

      <xsl:when test="$depth = 0">
	<xsl:choose>
	  <xsl:when test="$type='County'">
	    <xsl:value-of select="$name"/><xsl:text> County</xsl:text>	    
	  </xsl:when>
	  <xsl:when test="$type='Town'">
	    <xsl:text>Town of </xsl:text><xsl:value-of select="$name"/>
	  </xsl:when>
	  <xsl:when test="$type='City'">
	    <xsl:text>City of </xsl:text><xsl:value-of select="$name"/>	    
	  </xsl:when>
	  <xsl:when test="$type='District'">
	    <xsl:text>District of </xsl:text><xsl:value-of select="$name"/>	    
	  </xsl:when>
	  <xsl:when test="$type='Territory'">
	    <xsl:value-of select="$name"/><xsl:text> Territory</xsl:text>
	  </xsl:when>
	  <xsl:when test="$type='Ward'">
	    <xsl:text>Ward </xsl:text><xsl:value-of select="$name"/>
	  </xsl:when>
	  <xsl:when test="$type='Parish'">
	    <xsl:value-of select="$name"/><xsl:text> Parish</xsl:text>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$name"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>

      <xsl:otherwise>
	<xsl:call-template name="unit_name">
	  <xsl:with-param name="name" select="$name"/>
	  <xsl:with-param name="type" select="$type"/>
	  <xsl:with-param name="depth" select="$depth - 1"/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="sub_unit_depth">
    <xsl:param name="depth" select="0"/>
    <xsl:choose>
      <xsl:when test="parent::aas:sub_unit">
	<xsl:for-each select="parent::aas:sub_unit">
	  <xsl:call-template name="sub_unit_depth"><xsl:with-param name="depth" select="$depth+1"/></xsl:call-template>
	</xsl:for-each>
      </xsl:when>
      <xsl:otherwise><xsl:value-of select="$depth"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="aas:reference">
  </xsl:template>

 <xsl:template match="aas:note">
    <xsl:call-template name="inlineNote">
      <xsl:with-param name="node-id" select="generate-id(.)"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="inlineNote">
    <xsl:param name="node-id"/>
    
    <xsl:for-each select="//aas:note[not(./text() = preceding::aas:note/text())]">
      <xsl:variable name="note-text" select="normalize-space(string(.))"/>
      <xsl:variable name="note-pos"  select="position()"/>

      <xsl:for-each select="//aas:note[normalize-space(string(.)) = $note-text]">
	<xsl:if test="$node-id = generate-id(.)">
	  <a href="#note_{$note-pos}"> [<xsl:value-of
	  select="$note-pos"/>] </a>
	</xsl:if>
      </xsl:for-each>
      
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="footnotes">
    <xsl:if test="//aas:note">
      <div id="electionNotes">
	<h2>Notes:</h2>
	<xsl:for-each select="//aas:note[not(./text() = preceding::aas:note/text())]">
	  <xsl:variable name="note-text" select="normalize-space(string(.))"/>
	  <xsl:variable name="note-pos"  select="position()"/>
	  
	  <div class="footnote">
	    <a id="note_{$note-pos}"><span class="label">[<xsl:value-of select="$note-pos"/>] </span></a>
	    <span class="data"><xsl:value-of select="$note-text"/></span>
	  </div>
	  
	</xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="spacer">
    <xsl:param name="sp-class"/>
    <tr class="{$sp-class}"><td colspan="{count(/aas:election_record/aas:office/aas:role/aas:ballot/aas:candidate)+1}">&#160;</td></tr>
  </xsl:template>

  <xsl:template name="references">
    <xsl:if test="//aas:reference[@type='citation']">
      <div id="electionReferences">
	<h2>References:</h2>
	<xsl:for-each select="//aas:reference[@type='citation' and not(./text() = preceding::aas:reference/text())]">
	  <div class="reference-citation">
	    <xsl:value-of select="."/>
	  </div>
	</xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="page-images">
    <xsl:if test="//aas:reference[@type='page_image']">
      <h2>Page Images:</h2>
      <xsl:for-each select="//aas:reference[@type='page_image' and not (./@urn = preceding::aas:reference/@urn)]">
	<figure class="page-image">
      <xsl:variable name="uri" select="substring(@urn, 24)" />
	  <img src="http://repository01.lib.tufts.edu:8080/fedora/get/tufts{$uri}/bdef:TuftsImage/getMediumRes" alt="handwritten notes" />
    <figcaption>Phil's original notebook pages that were used to compile this election. These notes are considered a draft of the electronic version. Therefore, the numbers may not match. To verifiy numbers you will need to check the original sources cited. Some original source material is available at the American Antiquarian Society (<a href="www.americanantiquarian.org">www.americanantiquarian.org</a>).</figcaption>
 	</figure>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
