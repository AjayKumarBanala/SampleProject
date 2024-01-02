/*
Run this script on SQL Server 2008 or later. There may be flaws if running on earlier versions of SQL Server.
*/
CREATE XML SCHEMA COLLECTION [Sales].[StoreSurveySchemaCollection] AS N'
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey" elementFormDefault="qualified">
  <xsd:element name="StoreSurvey">
    <xsd:complexType>
      <xsd:complexContent>
        <xsd:restriction base="xsd:anyType">
          <xsd:sequence>
            <xsd:element name="ContactName" type="xsd:string" minOccurs="0"></xsd:element>
            <xsd:element name="JobTitle" type="xsd:string" minOccurs="0"></xsd:element>
            <xsd:element name="AnnualSales" type="xsd:decimal" minOccurs="0"></xsd:element>
            <xsd:element name="AnnualRevenue" type="xsd:decimal" minOccurs="0"></xsd:element>
            <xsd:element name="BankName" type="xsd:string" minOccurs="0"></xsd:element>
            <xsd:element name="BusinessType" type="t:BusinessType" minOccurs="0"></xsd:element>
            <xsd:element name="YearOpened" type="xsd:gYear" minOccurs="0"></xsd:element>
            <xsd:element name="Specialty" type="t:SpecialtyType" minOccurs="0"></xsd:element>
            <xsd:element name="SquareFeet" type="xsd:float" minOccurs="0"></xsd:element>
            <xsd:element name="Brands" type="t:BrandType" minOccurs="0"></xsd:element>
            <xsd:element name="Internet" type="t:InternetType" minOccurs="0"></xsd:element>
            <xsd:element name="NumberEmployees" type="xsd:int" minOccurs="0"></xsd:element>
            <xsd:element name="Comments" type="xsd:string" minOccurs="0"></xsd:element>
          </xsd:sequence>
        </xsd:restriction>
      </xsd:complexContent>
    </xsd:complexType>
  </xsd:element>
  <xsd:simpleType name="BrandType">
    <xsd:restriction base="xsd:string">
      <xsd:enumeration value="AW"></xsd:enumeration>
      <xsd:enumeration value="2"></xsd:enumeration>
      <xsd:enumeration value="3"></xsd:enumeration>
      <xsd:enumeration value="4+"></xsd:enumeration>
    </xsd:restriction>
  </xsd:simpleType>
  <xsd:simpleType name="BusinessType">
    <xsd:restriction base="xsd:string">
      <xsd:enumeration value="BM"></xsd:enumeration>
      <xsd:enumeration value="BS"></xsd:enumeration>
      <xsd:enumeration value="D"></xsd:enumeration>
      <xsd:enumeration value="OS"></xsd:enumeration>
      <xsd:enumeration value="SGS"></xsd:enumeration>
    </xsd:restriction>
  </xsd:simpleType>
  <xsd:simpleType name="InternetType">
    <xsd:restriction base="xsd:string">
      <xsd:enumeration value="56kb"></xsd:enumeration>
      <xsd:enumeration value="ISDN"></xsd:enumeration>
      <xsd:enumeration value="DSL"></xsd:enumeration>
      <xsd:enumeration value="T1"></xsd:enumeration>
      <xsd:enumeration value="T2"></xsd:enumeration>
      <xsd:enumeration value="T3"></xsd:enumeration>
    </xsd:restriction>
  </xsd:simpleType>
  <xsd:simpleType name="SpecialtyType">
    <xsd:restriction base="xsd:string">
      <xsd:enumeration value="Family"></xsd:enumeration>
      <xsd:enumeration value="Kids"></xsd:enumeration>
      <xsd:enumeration value="BMX"></xsd:enumeration>
      <xsd:enumeration value="Touring"></xsd:enumeration>
      <xsd:enumeration value="Road"></xsd:enumeration>
      <xsd:enumeration value="Mountain"></xsd:enumeration>
      <xsd:enumeration value="All"></xsd:enumeration>
    </xsd:restriction>
  </xsd:simpleType>
</xsd:schema>'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Collection of XML schemas for the Demographics column in the Sales.Store table.', 'SCHEMA', N'Sales', 'XML SCHEMA COLLECTION', N'StoreSurveySchemaCollection'
GO
