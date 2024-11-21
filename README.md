# Skapa en skalbar och säker serverlös miljö med AWS

Denna uppgift handlar om att skapa en **skalbar**, serverlös värdmiljö för en webbapplikation med AWS-tjänster.  
Lösningen är byggd med **AWS CloudFormation** och inkluderar följande:

## **Huvudkomponenter**
- **Amazon DynamoDB**: Lagrar kontaktinformation från användare.
- **AWS Lambda**: Bearbetar data och integrerar mellan tjänster:
  - `AddContactInfo`: Lagrar användardata till DynamoDB.
  - `SendContactInfoEmail`: Skickar notifikationer via Amazon SES.
- **Amazon API Gateway**: Publicerar API:et som exponerar Lambda-funktionalitet för frontend.
- **Amazon S3**: Värdar frontend-filer (HTML, CSS, JavaScript).
- **Amazon SES**: Skickar e-postmeddelanden med kontaktinformationen.
- **AWS CodePipeline**: Automatiserar distribution från GitHub till S3.

---

## **Steg-för-steg-beskrivning av lösningen**
### **Frontend-lagring**
- Använd **Amazon S3** för att värda webbapplikationen.
- Skapa en bucket med offentlig åtkomst för GET-förfrågningar.

### **API för kontaktinformation**
- Skapa ett **REST API** med **API Gateway** kopplat till Lambda-funktionen `AddContactInfo` via **AWS_PROXY-integration**.

### **Databas för lagring**
- Konfigurera en **DynamoDB-tabell** för att spara inskickade formulärdata.
- Aktivera streams för att trigga Lambda-funktioner vid nya poster.

### **E-postnotifikationer**
- Implementera Lambda-funktionen `SendContactInfoEmail` som triggas av DynamoDB-streams.
- Konfigurera **Amazon SES** för att skicka e-post med data från DynamoDB.

### **Automation och CI/CD**
- Konfigurera **AWS CodePipeline** för att dra kod från GitHub och distribuera frontend-filer till S3.

### **Infrastructure as Code (IaC)**
Lösningen använder CloudFormation för att:  
- Automatisera distribution av resurser.  
- Underlätta skalbarhet.  
- Göra lösningen repeterbar och enkel att underhålla.  

---

## **Skalbarhet**
Lösningen är mycket skalbar tack vare serverlösa AWS-tjänster:  
- **DynamoDB**: Skalar automatiskt med PAY_PER_REQUEST för att hantera stora datamängder.  
- **Lambda**: Eventdriven funktionalitet som skalar efter behov.  
- **API Gateway**: Hanterar miljontals förfrågningar per sekund.  
- **S3 & SES**: Skalar effektivt för lagring och e-posthantering.  
- **CodePipeline**: Säkerställer snabb och pålitlig distribution.  

### **Förbättringar för ännu bättre skalbarhet**
- **Caching med CloudFront**: Minska latens och avlasta backend.  
- **Global distribution**: Använd **DynamoDB Global Tables** och **CloudFront** för låg latens globalt.  
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
- **API Gateway Auth**: Använd **AWS Cognito** eller IAM-roller för autentisering.  
- **S3 Bucket Policy**: Begränsa åtkomst till specifika IP-adresser eller AWS-tjänster.  
- **Encryption**: Aktivera kryptering för DynamoDB och S3 för data i vila.  
- **Logging och övervakning**: Använd **CloudTrail** och **CloudWatch Logs**.  
- **WAF (Web Application Firewall)**: Skydda mot SQL-injektion och DDoS-attacker.  

---

Lösningen är byggd för att möta både skalbarhet och säkerhet och följer AWS:s bästa praxis. Den kan vidareutvecklas för global tillgänglighet och ännu högre skyddsnivåer.
