import io
archivo_txt = open("Tempo.txt",'w+')
#cosa = ["SwordWeaponUnlockLocation", "BowWeaponUnlockLocation", "SpearWeaponUnlockLocation","ShieldWeaponUnlockLocation","FistWeaponUnlockLocation","GunWeaponUnlockLocation","FountainUpgrade1Location","FountainUpgrade2Location","FountainTartarusLocation","FountainAsphodelLocation","FountainElysiumLocation","UrnsOfWealth1Location","UrnsOfWealth2Location","UrnsOfWealth3Location","InfernalThrove1Location","InfernalThrove2Location","InfernalThrove3Location","KeepsakeCollectionLocation","DeluxeContractorDeskLocation","VanquishersKeepLocation","FishingRodLocation","CourtMusicianSentenceLocation","CourtMusicianStandLocation","PitchBlackDarknessLocation","FatedKeysLocation","BrilliantGemstonesLocation","VintageNectarLocation","DarkerThirstLocation"]
cosa = ["IsThereNoEscape?","DistantRelatives","ChthonicColleagues","TheReluctantMusician","GoddessOfWisdom","GodOfTheHeavens","GodOfTheSea","GoddessOfLove","GodOfWar","GoddessOfTheHunt","GodOfWine","GodOfSwiftness","GoddessOfSeasons","PowerWithoutEqual","DivinePairings","PrimordialBoons","PrimordialBanes","InfernalArms","TheStygianBlade","TheHeartSeekingBow","TheShieldOfChaos","TheEternalSpear","TheTwinFists","TheAdamantRail","MasterOfArms","AViolentPast","HarshConditions","SlashedBenefits","WantonRansacking","ASimpleJob","ChthonicKnowledge","CustomerLoyalty","DarkReflections","CloseAtHeart","DenizensOfTheDeep","TheUselessTrinket"]
for i in cosa:
   archivo_txt.write("\t\t\t\t\t{"+"\n"+"\t\t\t\t\t\t"+"\"name\": \""+str(i)+"\","+"\n"+"\t\t\t\t\t\t"+"\"item_count\": 1"+"\n"+"\t\t\t\t\t},"+"\n")
# Localizaciones Rooms
#Hades_init = 5093428433 # F-5093428073;Sw-5093428145;Sh-5093428217; G-5093428289; Sp-5093428361;B-5093428433 
#for i in range(14):
#    archivo_txt.write("\t["+str(Hades_init+i)+"] = {\"@Tartarus/Tartarus Bow/Room "+str(i+1)+"\", \"ClearRoom"+str(i+1)+"BowWeapon\"},"+"\n")
#for i in range(14, 24):
#    archivo_txt.write("\t["+str(Hades_init+i)+"] = {\"@Asphodel/Asphodel Bow/Room "+str(i+1)+"\", \"ClearRoom"+str(i+1)+"BowWeapon\"},"+"\n")
#for i in range(24, 36):
#    archivo_txt.write("\t["+str(Hades_init+i)+"] = {\"@Elysium/Elysium Bow/Room "+str(i+1)+"\", \"ClearRoom"+str(i+1)+"BowWeapon\"},"+"\n")
#for i in range(36, 72):
#    archivo_txt.write("\t["+str(Hades_init+i)+"] = {\"@Styx/Styx Bow/Room "+str(i+1)+"\", \"ClearRoom"+str(i+1)+"BowWeapon\"},"+"\n")    