class Eve::Dump::Prerelease::Table
  TABLE_DEFINITION_REGEX = /CREATE TABLE `([^`]+)` \((.*)?\) ENGINE=MyISAM/m

  TABLES_TO_MODELS = {
    'agtAgentTypes' => 'Agent::AgentType',
    'agtAgents' => 'Agent',
    'agtConfig' => 'Agent::Config',
    'agtResearchAgents' => 'Agent::ResearchAgent',
    'chrAncestries' => 'Character::Ancestry',
    'chrAttributes' => 'Character::Attribute',
    'chrBloodlines' => 'Character::Bloodline',
    'chrFactions' => 'Character::Faction',
    'chrRaces' => "Character::Race",
    'crpActivities' => "Corporation::Activity",
    "crpNPCCorporationDivisions" => 'Corporation::NPC::CorpDivision',
    'crpNPCCorporationResearchFields' => 'Corporation::NPC::CorpResearchField',
    'crpNPCCorporationTrades' => 'Corporation::NPC::CorpTrade',
    'crpNPCDivisions' => 'Corporation::NPC::Division',
    'crtCategories' => 'Certificate::Category',
    'crtCertificates' => 'Certificate',
    'crtClasses' => 'Certificate::Class',
    'crtRecommendations' => 'Certificate::Recommendation',
    'crtRelationships' => 'Certificate::Relationship',
    'dgmAttributeCategories' => 'DGM::AttributeCategory',
    'dgmAttributeTypes' => 'DGM::AttributeType',
    'dgmEffects' => 'DGM::Effect',
    'dgmTypeAttributes' => 'DGM::TypeAttribute',
    'eveGraphics' => 'Eve::Graphic',
    'eveNames' => 'Eve::Name',
    'eveUnits' => "Eve::Unit",
    "invBlueprintTypes" => "Invention::BlueprintType",
    "invCategories" => "Invention::Category",
    "invContrabandTypes" => "Invention::ContrabandType",
    "invControlTowerResourcePurposes" => "Invention::ControlTowerResourcePurpose",
    "invControlTowerResources" => "Invention::ControlTowerResource",
    "invFlags" => "Invention::Flag",
    "invGroups" => "Invention::Group",
    "invMarketGroups" => "Invention::MarketGroup",
    "invMetaGroups" => "Invention::MetaGroup",
    "invTypeMaterials" => "Invention::TypeMaterial",
    "invTypeReactions" => "Invention::TypeReaction",
    "invTypes" => "Invention::Type",
    "mapCelestialStatistics" => "Map::CelestialStatistic",
    "mapConstellationJumps" => "Map::ConstellationJump",
    "mapConstellations" => "Map::Constellation",
    "mapDenormalize" => "Map::Denormalize",
    "mapJumps" => "Map::Jump",
    "mapLandmarks" => "Map::Landmark",
    "mapLocationScenes" => "Map::LocationScene",
    "mapLocationWormholeClasses" => "Map::LocationWormholeClass",
    "mapRegionJumps" => "Map::RegionJump",
    "mapRegions" => "Map::Region",
    "mapSolarSystemJumps" => "Map::SolarSystemJump",
    "mapSolarSystems" => "Map::SolarSystem",
    "mapUniverse" => "Map::Universe",
    "ramActivities" => "Ram::Activity",
    "ramAssemblyLineStations" => "Ram::AssemblyLineStation",
    "ramAssemblyLineTypeDetailPerCategory" => "Ram::AssemblyLineTypeDetailPerCategory",
    "ramAssemblyLineTypeDetailPerGroup" => "Ram::AssemblyLineTypeDetailPerGroup",
    "ramAssemblyLineTypes" => "Ram::AssemblyLineType",
    "ramAssemblyLines" => "Ram::AssemblyLine",
    "ramInstallationTypeContents" => "Ram::InstallationTypeContent",
    "ramTypeRequirements" => "Ram::TypeRequirement",
    "staOperationServices" => "Station::OperationService",
    "staOperations" => "Station::Operation",
    "staServices" => "Station::Service",
    "staStationTypes" => "Station::Type",
    "staStations" => "Station",
    "trnTranslationColumns" => "Translation::TranslationColumn",
    "trnTranslations" => "Translation"
  }.freeze

  attr_reader :fields, :name, :insertions

  def initialize(table_definition)
    @insertions = []
    parse_sql(table_definition)
  end

  def model_name
    TABLES_TO_MODELS[name]
  end

  def add_insertion(values)
    values = values.split(/,/)
    
    insertion = fields.inject({}) do |hash, field|
      hash[field] = values[fields.index(field)]
      hash
    end
    insertions << insertion
    self
  end

  private
  def parse_sql(sql)
    sql =~ TABLE_DEFINITION_REGEX
    raise "Could not find table definition in #{sql.inspect}" unless $~ && $~[1]
    @name = $~[1]
    definition = $~[2]
    @fields = []
    /`([^`]+)`/.each_match(definition) do |match|
      @fields << match[1] unless match[0] =~ /PRIMARY KEY/ || @fields.include?(match[1])
    end
  end
end
