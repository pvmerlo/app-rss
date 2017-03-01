<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:portal="urn:enonic:xp:portal:1.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:content="http://purl.org/rss/1.0/modules/content/"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
                xmlns:slash="http://purl.org/rss/1.0/modules/slash/"
                exclude-result-prefixes="portal xs">

  <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>


  <xsl:variable name="date-format-string" select="'[FNn,*-3], [D01] [MNn,*-3] [Y0001] [H01]:[m01]:[s01] +0200'"/>
  <xsl:variable name="lastBuild" select="/root/items[1]/modifiedTime"/>

  <xsl:template match="/">
    <rss version="2.0">
      <channel>
        <title><xsl:value-of select="/root/site/displayName"/></title>
        <atom:link href="{/root/content/pageUrl}" rel="self" type="application/rss+xml"/>
        <link><xsl:value-of select="/root/content/pageUrl"/></link>
        <description><xsl:value-of select="/root/site/data/description"/></description>
        <lastBuildDate><xsl:value-of select="format-dateTime(xs:dateTime($lastBuild), $date-format-string)"/></lastBuildDate>
        <language><xsl:value-of select="/root/content/data/language"/></language>
        <xsl:if test="/root/content/data/updatePeriod and /root/content/data/updateFrequency">
          <sy:updatePeriod><xsl:value-of select="/root/content/data/updatePeriod"/></sy:updatePeriod>
          <sy:updateFrequency><xsl:value-of select="/root/content/data/updateFrequency"/></sy:updateFrequency>
        </xsl:if>
        <generator>Enonic XP</generator>

        <xsl:apply-templates select="/root/items"/>
      </channel>
    </rss>
  </xsl:template>

  <xsl:template match="item">
    <item>
      <title>
        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text><xsl:value-of select="title"/><xsl:text
              disable-output-escaping="yes">]]&gt;</xsl:text>
      </title>
      <link>
        <xsl:value-of select="link"/>
      </link>

      <xsl:if test="thumbnail">
        <xsl:text disable-output-escaping="yes">&lt;enclosure size="</xsl:text>
        <xsl:value-of select="thumbnail/size" />
        <xsl:text disable-output-escaping="yes">" type="</xsl:text>
        <xsl:value-of select="thumbnail/type" />
        <xsl:text disable-output-escaping="yes">" url="</xsl:text>
        <xsl:value-of select="thumbnail/url" />
        <xsl:text disable-output-escaping="yes">" /&gt;</xsl:text>
      </xsl:if>
      <pubDate>
        <xsl:value-of select="format-dateTime(xs:dateTime(datePublished), $date-format-string)"/>
      </pubDate>
      <!--
            <dc:creator>
              <xsl:text disable-output-escaping="yes">&lt;![CDATA[ </xsl:text><xsl:value-of select="data/authorName"/><xsl:text
                disable-output-escaping="yes"> ]]&gt;</xsl:text>
            </dc:creator>
      -->
      <!--
            <xsl:for-each select="data/tags/item | data/categoryNames/item">
              <category>
                <xsl:text disable-output-escaping="yes">&lt;![CDATA[ </xsl:text><xsl:value-of select="."/><xsl:text disable-output-escaping="yes"> ]]&gt;</xsl:text>
              </category>
            </xsl:for-each>
      -->
      <guid isPermaLink="false">
        <xsl:value-of select="link"/>
      </guid>

      <description>
        <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text><xsl:value-of select="summary"/><xsl:text
              disable-output-escaping="yes">]]&gt;</xsl:text>
      </description>
      <!--
            <content:encoded>
              <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text><xsl:value-of select="data/post" disable-output-escaping="yes"/><xsl:text
                disable-output-escaping="yes">]]&gt;</xsl:text>
            </content:encoded>
      -->
    </item>
  </xsl:template>

</xsl:stylesheet>
