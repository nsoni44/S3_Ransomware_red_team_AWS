#!/usr/bin/env bash
# ============================================================
# Script Name : s3_to_csv.sh
# Purpose     : Extract all "Keys" from an S3 bucket, download
#               each object, and save Key + Base64 content to CSV.
# Bucket Name : stratus-red-team-ransomware-bucket-jduvyr
# Output File : s3_objects.csv
# Requires    : aws-cli, jq, base64, bash
# ============================================================

set -euo pipefail

# -----------------------------
# 1. Configuration
# -----------------------------
BUCKET="stratus-red-team-ransomware-bucket-******"   # Hardcoded bucket name (***** need to replace with your own authenticated bucket)
OUT="s3_objects.csv"                                 # Output CSV file
TMP_LIST="$(mktemp)"                                 # Temporary file for object listing

# -----------------------------
# 2. Initialize CSV Header
# -----------------------------
printf '"Key","Content_base64"\n' > "$OUT"

# -----------------------------
# 3. List S3 objects (first 1000)
# -----------------------------
echo "[+] Listing objects from bucket: $BUCKET ..."
aws s3api list-objects-v2 --bucket "$BUCKET" --output json > "$TMP_LIST"

# -----------------------------
# 4. Extract keys and download objects
# -----------------------------
echo "[+] Processing objects and writing to CSV..."

jq -r '.Contents[].Key' "$TMP_LIST" | while IFS= read -r key; do
  # Escape double quotes in key for safe CSV output
  key_escaped=${key//\"/\"\"}

  # Start new CSV row with key
  printf '"%s",' "$key_escaped" >> "$OUT"

  # Download object, encode as base64, remove newlines, append to CSV
  aws s3 cp "s3://$BUCKET/$key" - 2>/dev/null | base64 | tr -d '\n' >> "$OUT"

  # End of CSV line
  echo >> "$OUT"

  # Optional progress dot
  printf '.'
done

echo
echo "[✓] Done! CSV saved as: $OUT"

# -----------------------------
# 5. Cleanup
# -----------------------------
rm -f "$TMP_LIST"
