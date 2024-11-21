# Skapa en skalbar och säker serverlös miljö med AWS

Denna uppgift handlar om att skapa en **skalbar**, serverlös värdmiljö för en webbapplikation med AWS-tjänster.
Lösningen är byggd med **AWS CloudFormation** och inkluderar följande:

## **Huvudkomponenter**
- **Amazon DynamoDB**: Lagrar kontaktinformation från användare.
- **AWS Lambda**: Bearbetar data och integrerar mellan tjänster:
  - `AddContactInfo`: Lagrar användardata till DynamoDB.
  - `SendContactInfoEmail`: Skickar notifikationer via Amazon SES.
- **Amazon API Gateway**: Publicerar API:et som exponerar Lambda-funktionalitet för frontend.
- **Amazon S3**: Hostar frontend-filer (Index.html).
- **Amazon SES**: Skickar e-postmeddelanden med kontaktinformationen.
- **AWS CodePipeline**: Automatiserar distribution från GitHub till S3.

---

## **Steg-för-steg-beskrivning av lösningen**
### **Frontend-lagring**
- Använder **Amazon S3** för att hosta appen/formuläret.
- Skapar en bucket med offentlig åtkomst för GET-förfrågningar.

### **API för kontaktinformation**
- Skapar ett **REST API** med **API Gateway** kopplat till Lambda-funktionen `AddContactInfo` via **AWS_PROXY-integration**.

### **Databas för lagring**
- Konfigurera en **DynamoDB-tabell** för att spara inskickade formulärdata.
- Aktiverar streams för att trigga Lambda-funktioner vid nya poster.

### **E-postnotifikationer**
- Implementerar Lambda-funktionen `SendContactInfoEmail` som triggas av DynamoDB-streams.
- Konfigurera **Amazon SES** för att skicka e-post med data från DynamoDB.

### **Automation och CI/CD**
- Konfigurera **AWS CodePipeline** för att dra kod från GitHub och distribuera frontend-filer till S3.

### **Infrastructure as Code (IaC)**
Lösningen använder CloudFormation för att:
- Automatisera distribution av resurser.
- Underlätta skalbarhet.
- Göra lösningen enkel att upprepa och underhålla.  

---

## **Skalbarhet**
Lösningen är mycket skalbar tack vare serverlösa AWS-tjänster:  
- **DynamoDB**: Skalar automatiskt med PAY_PER_REQUEST för att hantera stora datamängder.  
- **Lambda**: Eventdriven funktionalitet som skalar efter behov.  
- **API Gateway**: Kan hantera miljontals förfrågningar per sekund.  
- **S3 & SES**: Skalar effektivt för lagring och e-posthantering.  
- **CodePipeline**: Säkerställer snabb och pålitlig distribution.  

### **Förbättringar för ännu bättre skalbarhet**
- **Caching med CloudFront**: Minska latens och avlasta backend.  
- **Global distribution**: Använd **DynamoDB Global Tables** och **CloudFront** för låg latens globalt. Avlastar även backend genom att cachelagra statiska resurser och svar från API:et minskas belastningen på S3, Lambda och API Gateway.  
- **Kvotjustering**: Höj gränser för Lambda, SES och API Gateway vid förväntad extrem trafik.  

---

## **Säkerhet**
Lösningen prioriterar säkerhet med hjälp av AWS:s inbyggda funktioner:  
- **IAM Roller och Policyer**: Begränsad åtkomst för Lambda-funktioner.  
- **API Gateway**: Stöd för **CORS** och **HTTPS** säkrar anslutningar.  
- **Amazon S3**: Offentlig åtkomst begränsas till specifika objekt, och **PublicAccessBlock** hanterar policyer.  
- **Secrets Manager**: Säker lagring av GitHub-token för distribution.  
- **DynamoDB Streams**: Endast auktoriserade Lambda-funktioner har åtkomst.  

### **Förbättringar för ännu högre säkerhet**
- **Cloud Front**: Stöd för AWS Web Application Firewall (WAF) för skydd mot vanliga hot som SQL-injektion och bot-trafik.
  HTTPS-stöd via ACM (Amazon Certificate Manager) säkerställer säkra anslutningar. Skydd mot DDoS-attacker genom integration med AWS Shield.
- **API Gateway Auth**: Använd **AWS Cognito** eller IAM-roller för autentisering.  
- **S3 Bucket Policy**: Begränsa åtkomst till specifika IP-adresser eller AWS-tjänster.  
- **Encryption**: Aktivera kryptering för DynamoDB och S3 för data i vila.  
- **Logging och övervakning**: Använd **CloudTrail** och **CloudWatch Logs**.  
- **WAF (Web Application Firewall)**: Skydda mot SQL-injektion och DDoS-attacker.  

---

Genom att inkludera CloudFront i lösningen kan applikationen göras ännu mer skalbar, säker och prestandaeffektiv, särskilt vid hög trafik eller en global användarbas.


Lösningen är byggd för att möta både skalbarhet och säkerhet och följer AWS:s bästa praxis. Den kan vidareutvecklas för global tillgänglighet och ännu högre skyddsnivåer.

# Att använda Scriptet:
- Ladda ner Deploy.sh, Template.yaml och Index.html.
- Template.yaml: Ändra variablerna längst upp som passar din miljö.
- Index.html: Se till så länken i API URL är tom, detta kommer automatiskt uppdateras när scriptet körs till API-endpoint url. "_ApiUrl = \"<>\"_"
- Deploy.sh: Dubbelkolla variabler
- Kör scriptet: Ställ terminalen där du lagt filerna och kör "./Deploy.sh".
