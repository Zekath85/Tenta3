#!/bin/bash

# Variabler
STACK_NAME="contactstack"
TEMPLATE_FILE="Template.yaml"
INDEX_FILE="index.html"

# Skapa stacken
aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://$TEMPLATE_FILE --capabilities CAPABILITY_NAMED_IAM

# Vänta tills stacken är skapad
echo "Väntar på att stacken ska bli klar..."
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME

# Hämta API-endpoint URL
API_URL=$(aws cloudformation describe-stacks --stack-name "$STACK_NAME" --query "Stacks[0].Outputs[?OutputKey=='ApiEndpoint'].OutputValue" --output text)

# Kolla om API_URL är hämtad korrekt
if [[ -z "$API_URL" ]]; then
    echo "Fel: Kunde inte hämta API URL."
    exit 1
fi

echo "API URL: $API_URL"

# Uppdatera index.html med API URL
sed -i "s|ApiUrl = \"<>\"|ApiUrl = \"$API_URL\"|g" "$INDEX_FILE"

# Kontrollera om det finns ändringar att commit:a
    git status

    # Lägg till ändringar i Git
    git add "$INDEX_FILE"
    git commit -m "Uppdaterade API URL i index.html"

    # Pusha ändringarna till GitHub
    git push

echo "Deployment klart!"
