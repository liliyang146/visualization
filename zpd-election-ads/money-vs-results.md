# Partiju tēriņi un rezultāti

[Uz sākumu](http://85.254.250.28/downloads1/zpd-election-ads/)  
**Anotācija:** Šajā lapā apkopoti partiju (oficiāli, KNABam iesniegtie) 
13.Saeimas priekšvēlēšanu kampaņas izdevumi. 

## Partiju deklarācijas

**Datu savākšanas metodika:**

1. Apciemo KNAB mājaslapu: [https://www.knab.gov.lv/lv/db/declaration/](https://www.knab.gov.lv/lv/db/declaration/)
2. Izvēlas no saraksta kādu no partijām, kas ieguva vismaz 2% 13.Saeimas vēlēšanās. 
3. Izvēlas gadu "2018" un deklarācijas veidu "Vēlēšanu ieņēmumu un izdevumu deklarācija". 
4. Spiež pogu **Meklēt**. 
![Deklarāciju izvēles forma](declarations/party-declarations.png)
5. Ja parādās vairāki rezultāti, tad izvēlamies jaunāko no tiem.

**Saraksts ar deklarācijām:**

1. ["Saskaņa" sociāldemokrātiskā partija](declarations/Sask.pdf)
2. [Politiskā partija “KPV LV”](declarations/KPV.pdf)
3. [Jaunā konservatīvā partija](declarations/JKP.pdf)
4. [Attīstībai/Par!](declarations/A-PAR.pdf)
5. [Nacionālā apvienība VL-TB/LNNK](declarations/NA.pdf)
6. [Zaļo un Zemnieku savienība](declarations/ZZS.pdf)
7. [Jaunā Vienotība](declarations/JV.pdf)
8. [Latvijas Reģionu Apvienība](declarations/LRA.pdf)
9. [Latvijas Krievu savienība](declarations/LKS.pdf)
10. [Progresīvie](declarations/Progr.pdf)


## CSV datu fails

Valsts iestādes (t.sk. KNAB) nereti glabā skenētus dokumentus. Mūsu gadījumā
PDF faili satur attēlus (faktiski partiju finanšu dokumentu fotogrāfijas). 
Mūs interesējošās tabulu ailes būtu grūti automatizēti atrast (katrai partijai 
tabulas izkārtojums nedaudz atšķiras). Nav arī vienkārši tos bez kļūdām pārvērst 
no attēla skaitliskā formātā (veikt OCR - *optical character recognition*). 
Pirms partiju izdevumus var apstrādāt kā skaitļus un attēlot diagrammās, tie ar roku jāpārraksta 
izklājlapas tabulā.

Populārs mašīnlasāmu datu formāts ir CSV (comma-separated values). To var iegūt, 
piemēram, saglabājot izklājlapu ar LibreOffice Calc programmu. 
(Var lietot arī citu populāru programmu - Microsoft Excel, bet tur var būt 
jāuzmanās ar ne-ASCII simbolu kodējumu, t.sk. latviešu burtiem ar diakritiskajām 
zīmēm.)

* [Partiju deklarāciju dati, ODS](declaration-data.ods) - LibreOffice izklājlapas formāts
* [Partiju deklarāciju dati, CSV](declaration-data.csv) - Vienkārša teksta formāts

## Diagrammas

Softs, ar kuru zīmētas stabiņu diagrammas (valoda R): [barcharts.R](barcharts.R)

**Vienas vēlētāja balss izmaksas atkarībā no partijas**

![Diagramma Nr.1: Vienas balss cena](declarations/barchart1.png)

**Vienas deputāta vietas izmaksas atkarībā no partijas**

![Diagramma Nr.2: Vienas deputāta vietas cena](declarations/barchart2.png)

## Secinājumi

1. Visdārgāk pārliecināmais vēlētājs bija ZZS (EUR 12.92 par balsi), bet vislētāk pārliecināmais - 
no KPV (EUR 1.10 par balsi). Cenu atšķirība ir $12.92/1.10=11.75$ jeb gandrīz
$12$ reizes. Mums nav pamata uzskatīt, ka minēto partiju kampaņas būtu veidotas neprofesionāli. 
Iespējams, atšķīrās vēstījuma saturs - ZZS vairāk saistījās ar esošo varu 
("Saimnieki savā zemē", "Labo darbu čempioni"), kurpretī KPV vairāk akcentēja savu 
ārpussistēmas politiķu, jaunpienācēju lomu.
2. Visai lēti un efektīvi bija Alda Gobzema filmētie video (gandrīz nerediģēti 
ieraksti - tiešsaistes tikšanās ar vēlētājiem Facebook), kuros viņš 
brauc automašīnā un stāsta KPV programmas nostādnes. Piemēram, ko nozīmē 
tēze "Valstij ir jāsāk ar sevi". Te konkurējošas partijas deputātu kandidāta
Edmunda Jurēvica (Vienotība) ierakstīta parodija: 
[Galdis Obzems beidzot pateica kā ir!](https://twitter.com/EdmundsJurevics/status/1032695865557827585).
Alda Gobzema klipu oriģināli, diemžēl jau izdzēsti no YouTube. Sal. 
[https://twitter.com/AldisGobzems/status/1046136651125313537](https://twitter.com/AldisGobzems/status/1046136651125313537), bet E.Jurēvica parodija diezgan pareizi attēlo šī veida reklāmas klipu 
kompozīciju.
3. **Ko gribētos pētīt tālāk?** Var salīdzināt ZZS, JV (dārgākās reklāmas kampaņas) 
un KPV, JKP (lētākās reklāmas kampaņas) iesniegtās deklarācijas, 
saprast reklāmas izdevumu sadalījumu pa reklāmu veidiem. Ļoti iespējams, ka KPV un JKP 
izdevumu struktūra parāda, kā mūsdienās efektīvāk veidot vēlēšanu kampaņas.


