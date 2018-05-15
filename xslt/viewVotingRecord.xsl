<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   exclude-result-prefixes="aas">
  <!-- Once included xmlns:aas="http://dca.tufts.edu/aas", but dont' need it now. -->

  <xsl:output method="xml" indent="no"
    doctype-public="-//W3C//DTD XHTML 1.1//EN"
    doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
    encoding="US-ASCII" />


  <xsl:template match="/election_record">
    <xsl:apply-templates/>
    <!-- FOOTNOTES -->
    <xsl:call-template name="footnotes"/>
    <!-- REFERENCES -->
    <xsl:call-template name="references"/>
  </xsl:template>


  <xsl:template match="role" xmlns="http://www.w3.org/1999/xhtml">

    <div id="election-results">
      <xsl:if test="not(/elections/@style = 'print')">
        <!-- Header -->
        <div id="record-buttons">
          <a href="print-election.xq?id={@election_id}"
             onclick="window.open(this.href,'');return false;"
             class="link1"><img alt="print" src="images/print.gif"/> Printer Friendly</a>
        </div>
        <a href="search.xq" class="link1">&lt; back to search results</a><br/>
        <a href="advanced-search.xq" class="link1">&lt; new search</a><br/>
        <a href="advanced-search.xq?modify-search=true" class="link1">&lt; modify search</a><br/>
      </xsl:if>

     <!-- Main results table --> 
     <div id="record-header">
       <span class="text8"><xsl:value-of select="@label"/></span>
       <div id="record-subheader" class="text1">
         <span class="label">Office: </span><xsl:value-of select="//office/@name"/>
                 (<xsl:value-of select="//office/@scope"/>)<br/>
         <span class="label">Title: </span><xsl:value-of select="//role/@title"/><br/>
         <span class="label">Jurisdiction: </span><xsl:value-of select="//role/@scope"/><br/>

         <xsl:if test="not(/elections/@style = 'print')">
           <a href="more-info.xq?id={@election_id}"
              onclick="window.open(this.href,'');return false;"
              class="link4">[view more information]</a><br/>
           <a href="view-pages.xq?id={@election_id}"
              onclick="window.open(this.href,'');return false;"
              class="link4">[view Philip Lampi's original tabulations]</a><br/>
         </xsl:if>
       </div>
     </div>

     <xsl:apply-templates/>

     <!-- FOOTNOTES -->
     <xsl:call-template name="footnotes"/>
     <!-- REFERENCES -->
     <xsl:call-template name="references"/>
   </div>
  </xsl:template>

  <xsl:template match="role"  xmlns="http://www.w3.org/1999/xhtml">
    <!-- The main presentation of results -->
    <table class="election-results-table" cellspacing="0">
      <thead>
      <xsl:choose>
        <xsl:when test="//elector">

        <!-- Electoral election: We display a few things a little differently when we have an electoral election -->
        <tr class="candidate-row">
          <th class="row-label">Electors: <xsl:apply-templates select="/election_record/office/role/ballot/note"/></th>
          <xsl:for-each select="/election_record/office/role/ballot/elector">
            <xsl:sort select="@elector_num" data-type="number"/>
            <th>
            <xsl:choose>
              <xsl:when test="normalize-space(@name_id) and @name_id != 'null'">
                <a href="/catalog/{@name_id}/track"><xsl:value-of select="@name"/></a>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@name"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="note"/>
            </th>
          </xsl:for-each>
        </tr>

        <tr class="affiliation-row">
          <th class="row-label">Affiliation:</th>
          <xsl:for-each select="//election_record/office/role/ballot/elector">
            <xsl:sort select="@elector_num" data-type="number"/>
            <td>
              <xsl:if test="normalize-space(@affiliation) != '' and normalize-space(@affiliation) != 'null'">
                <xsl:value-of select="@affiliation"/>
              </xsl:if>
            </td>
          </xsl:for-each>
        </tr>

        <tr class="declared-for-row">
          <th class="row-label">Presidential Candidate:</th>
          <xsl:for-each select="//election_record/office/role/ballot/elector">
            <xsl:sort select="@elector_num" data-type="number"/>
            <td>
              <xsl:if test="normalize-space(@declared_for) != '' and normalize-space(@declared_for) != 'null'">
                <xsl:value-of select="@declared_for"/>
              </xsl:if>
            </td>
          </xsl:for-each>
        </tr>

        <tr class="overview-row">
          <th>Final Result: <xsl:apply-templates select="//election_record/office/role/overview/note"/></th>
          <xsl:for-each select="//election_record/office/role/ballot/elector">
            <xsl:sort select="@elector_num" data-type="number"/>
            <xsl:variable name="elec_id" select="@elector_num"/>

            <xsl:variable name="x">
              <xsl:value-of select="//election_record/office/role/overview/elector_summary[@elector_ref=$elec_id]/@vote_total"/>
            </xsl:variable>

            <xsl:choose>
              <xsl:when test="normalize-space($x)=''"><td class="vote-nodata">-</td></xsl:when>
              <xsl:otherwise><td class="vote"><xsl:value-of select="$x"/></td></xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </tr>
        </xsl:when>
        <xsl:otherwise> 
         <!-- Normal candidatorial election -->
        <tr class="candidate-row">
          <th class="row-label">Candidates: <xsl:apply-templates select="/election_record/office/role/ballot/note"/></th>
          <xsl:for-each select="/election_record/office/role/ballot/candidate">
            <xsl:sort select="@candidate_num" data-type="number"/>
            <th>
              <xsl:choose>
                <xsl:when test="normalize-space(@name_id) and @name_id != 'null'">
                  <a href="/catalog/{@name_id}/track"><xsl:value-of select="@name"/></a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@name"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:apply-templates select="note"/>
            </th>
          </xsl:for-each>
        </tr>

        <tr class="affiliation-row">
          <th class="row-label">Affiliation:</th>
          <xsl:for-each select="/election_record/office/role/ballot/candidate">
            <xsl:sort select="@candidate_num" data-type="number"/>
            <td>
              <xsl:if test="normalize-space(@affiliation) != '' and normalize-space(@affiliation) != 'null'">
                <xsl:value-of select="@affiliation"/>
              </xsl:if>
            </td>
          </xsl:for-each>
        </tr>

        <tr class="overview-row">
          <th>Final Result: <xsl:apply-templates select="/election_record/office/role/overview/note"/></th>
          <xsl:for-each select="/election_record/office/role/ballot/candidate">
            <xsl:sort select="@candidate_num" data-type="number"/>
            <xsl:variable name="cand_id" select="@candidate_num"/>

            <xsl:variable name="x">
              <xsl:value-of select="/election_record/office/role/overview/candidate_summary[@candidate_ref=$cand_id]/@vote_total"/>
            </xsl:variable>

            <xsl:choose>
              <xsl:when test="normalize-space($x)=''"><td class="vote-nodata">-</td></xsl:when>
              <xsl:otherwise><td class="vote"><xsl:value-of select="$x"/></td></xsl:otherwise>
            </xsl:choose>

          </xsl:for-each>
        </tr>
        </xsl:otherwise>
        <!--  end Normal candidatorial election -->
      </xsl:choose>
      </thead>
      <xsl:apply-templates select="admin_unit"/>
    </table>
  </xsl:template>

  <xsl:template match="sub_unit"  xmlns="http://www.w3.org/1999/xhtml">
    <xsl:variable name="sub_unit" select="."/>
    <xsl:variable name="depth">
      <xsl:call-template name="sub_unit_depth"/>
    </xsl:variable>

    <tr>
      <xsl:attribute name="class">
        <xsl:text>sub-unit-row</xsl:text><xsl:value-of select="$depth"/>
        <xsl:text> text8</xsl:text>
        <xsl:choose>
        <xsl:when test="$depth &gt; 0">
          <xsl:text> sub-unit-alt</xsl:text>
          <xsl:value-of select="$depth" />
          <xsl:text>-</xsl:text>
          <xsl:value-of select="(position()-1) mod 2"/>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <th class="sub-unit-label{$depth}">
        <xsl:call-template name="unit_name">
          <xsl:with-param name="name" select="@name"/>
          <xsl:with-param name="type" select="@type"/>
        </xsl:call-template><xsl:apply-templates select="note"/>
      </th>

      <xsl:choose>
      <xsl:when test="//elector">
        <xsl:for-each select="//election_record/office/role/ballot/elector">
          <xsl:sort select="@elector_num" data-type="number"/>
          <xsl:variable name="elec_id" select="@elector_num"/>
          <xsl:variable name="x">
            <xsl:value-of select="$sub_unit/result[@elector_ref=$elec_id]/@vote"/>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="normalize-space($x)=''"><td class="vote-nodata">-</td></xsl:when>
            <xsl:otherwise><td class="vote"><xsl:value-of select="$x"/></td></xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="/election_record/office/role/ballot/candidate">
          <xsl:sort select="@candidate_num" data-type="number"/>
          <xsl:variable name="cand_id" select="@candidate_num"/>
          <xsl:variable name="x">
            <xsl:value-of select="$sub_unit/result[@candidate_ref=$cand_id]/@vote"/>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="normalize-space($x)=''"><td class="vote-nodata">-</td></xsl:when>
            <xsl:otherwise><td class="vote"><xsl:value-of select="$x"/></td></xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:otherwise>
      </xsl:choose>
    </tr>

    <xsl:apply-templates select="sub_unit"/>
  </xsl:template>

  <xsl:template name="election_title">
    <xsl:variable name="scope"><xsl:value-of select="/election_record/office/role/@scope"/></xsl:variable>

    <xsl:choose>
    <xsl:when test="//sub_unit[@type = $scope]">
      <xsl:call-template name="unit_name">
        <xsl:with-param name="name" select="//sub_unit[@type = $scope]/@name"/>
        <xsl:with-param name="type" select="$scope"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="unit_name">
        <xsl:with-param name="name" select="/election_record/office/role/admin_unit/@name"/>
        <xsl:with-param name="type" select="/election_record/office/role/admin_unit/@type"/>
      </xsl:call-template>
    </xsl:otherwise>
    </xsl:choose>

    <xsl:text> </xsl:text>
    <xsl:value-of select="/election_record/@date"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="/election_record/@type"/>
    <xsl:text> Election for </xsl:text>
    <xsl:value-of select="/election_record/office/role/@title"/>
    <xsl:if test="/election_record/@iteration != '' and /election_record/@iteration != 'null' and /election_record/@iteration != 'First Ballot'">
      <xsl:text> : </xsl:text>
      <xsl:value-of select="/election_record/@iteration"/>
    </xsl:if>
  </xsl:template>

  <!-- This template generates a human-consumable version of
       locality names.  It misses some special cases that might
       be nice to catch.  Eg, it outputs "District of 4" rather
       than "District 4", and "Ward 4th" rather than "4th Ward", etc.
    -->
  <xsl:template name="unit_name"  xmlns="http://www.w3.org/1999/xhtml">
    <xsl:param name="name"/>
    <xsl:param name="type"/>
    <span class="unit_name">
    <xsl:choose>
      <xsl:when test="$name='' or $name='null'"> </xsl:when>
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
    </span>
  </xsl:template>

  <xsl:template name="sub_unit_depth"  xmlns="http://www.w3.org/1999/xhtml">
    <xsl:param name="depth" select="0"/>
    <xsl:choose>
      <xsl:when test="parent::sub_unit">
        <xsl:for-each select="parent::sub_unit">
          <xsl:call-template name="sub_unit_depth"><xsl:with-param name="depth" select="$depth+1"/></xsl:call-template>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise><xsl:value-of select="$depth"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="reference"  xmlns="http://www.w3.org/1999/xhtml"> </xsl:template>

  <!-- Templates to put the footnote references in the candidate row -->
  <xsl:template match="note"  xmlns="http://www.w3.org/1999/xhtml">
    <xsl:call-template name="inlineNote">
      <xsl:with-param name="node-id" select="generate-id(.)"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="inlineNote"  xmlns="http://www.w3.org/1999/xhtml">
    <xsl:param name="node-id"/>
    <xsl:variable name="note-pos">
      <xsl:number level="any" />
    </xsl:variable>
    <xsl:if test="$node-id = generate-id(.)">
      <a href="#note_{$note-pos}" class="link4">[<xsl:value-of select="$note-pos"/>]</a>
    </xsl:if>
  </xsl:template>

  <!-- Templates to put the footnotes beneath the table -->
  <xsl:template name="footnotes"  xmlns="http://www.w3.org/1999/xhtml">
    <xsl:if test="//note">
      <div id="electionNotes">
        <h2>Notes:</h2>
        <xsl:for-each select="//note">
          <xsl:variable name="note-text" select="normalize-space(string(.))"/>
          <xsl:variable name="note-pos">
            <xsl:number level="any" />
          </xsl:variable>

          <div class="footnote">
            <a id="note_{$note-pos}" class="label">[<xsl:value-of select="$note-pos"/>]</a>
            <span class="data"><xsl:value-of select="$note-text"/></span>
          </div>
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="references"  xmlns="http://www.w3.org/1999/xhtml">
    <xsl:if test="//reference[@type='citation']">
      <div id="electionReferences">
        <h2>References:</h2>
        <xsl:for-each select="//reference[@type='citation' and not(./text() = preceding::reference/text())]">
          <div class="reference-citation">
            <xsl:value-of select="."/>
          </div>
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
