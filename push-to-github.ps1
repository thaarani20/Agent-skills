# Run from: C:\Users\2000153361\Downloads\RAG\Agent-skills
# Requires: empty repo https://github.com/thaaranisrinivasan/Agent-skills (create on GitHub first)
$repoUrl = "https://github.com/thaarani20/Agent-skills"
$api = "https://api.github.com/repos/thaarani20/Agent-skills"
try {
  Invoke-RestMethod -Uri $api -UseBasicParsing | Out-Null
  Write-Host "Remote repo exists. Pushing..."
} catch {
  Write-Host "Create the empty repo first: $repoUrl"
  Start-Process "https://github.com/new?name=Agent-skills&description=Agent+Skills+session+kit&visibility=public"
  exit 1
}
git remote set-url origin "$repoUrl.git"
git push -u origin main
if ($LASTEXITCODE -eq 0) { Write-Host "Done: $repoUrl" }
