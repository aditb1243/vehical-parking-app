param(
    [switch]$FirstRun = $false,
    [switch]$SkipInstall = $false
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Vehicle Parking App - Dev Setup      " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$ROOT_DIR = $PSScriptRoot
$FRONTEND_DIR = Join-Path $ROOT_DIR "frontend"
$BACKEND_DIR = Join-Path $ROOT_DIR "backend"

function Test-CommandExists {
    param($command)
    $null = Get-Command $command -ErrorAction SilentlyContinue
    return $?
}

function Test-PortInUse {
    param($port)
    $connection = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
    return $null -ne $connection
}

# Step : Check Prerequisites
Write-Host "[1/8] Checking prerequisites..." -ForegroundColor Yellow

$allPrereqsMet = $true

if (-not (Test-CommandExists "node")) {
    Write-Host "  ❌ Node.js is not installed. Please install Node.js from https://nodejs.org/" -ForegroundColor Red
    $allPrereqsMet = $false
} else {
    $nodeVersion = node --version
    Write-Host "  ✅ Node.js: $nodeVersion" -ForegroundColor Green
}

if (-not (Test-CommandExists "python")) {
    Write-Host "  ❌ Python is not installed. Please install Python from https://www.python.org/" -ForegroundColor Red
    $allPrereqsMet = $false
} else {
    $pythonVersion = python --version
    Write-Host "  ✅ Python: $pythonVersion" -ForegroundColor Green
}

if (-not (Test-CommandExists "docker")) {
    Write-Host "  ❌ Docker is not installed. Please install Docker Desktop from https://www.docker.com/" -ForegroundColor Red
    $allPrereqsMet = $false
} else {
    $dockerVersion = docker --version
    Write-Host "  ✅ Docker: $dockerVersion" -ForegroundColor Green
}

if (-not $allPrereqsMet) {
    Write-Host "`n❌ Missing prerequisites. Please install the required software and try again." -ForegroundColor Red
    exit 1
}

# Step 2: Check if Docker is running
Write-Host "`n[2/8] Checking Docker status..." -ForegroundColor Yellow

try {
    $dockerInfo = docker info 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ⚠️  Docker is not running. Starting Docker Desktop..." -ForegroundColor Yellow
        Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
        Write-Host "  ⏳ Waiting for Docker to start (this may take 30-60 seconds)..." -ForegroundColor Yellow
        
        $maxWait = 60
        $waited = 0
        while ($waited -lt $maxWait) {
            Start-Sleep -Seconds 5
            $waited += 5
            try {
                docker info 2>&1 | Out-Null
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "  ✅ Docker is now running" -ForegroundColor Green
                    break
                }
            } catch {}
        }
        
        if ($waited -ge $maxWait) {
            Write-Host "  ❌ Docker failed to start within $maxWait seconds. Please start Docker Desktop manually." -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "  ✅ Docker is running" -ForegroundColor Green
    }
} catch {
    Write-Host "  ❌ Error checking Docker status: $_" -ForegroundColor Red
    exit 1
}

# Step 3: Check and start Redis container
Write-Host "`n[3/8] Setting up Redis..." -ForegroundColor Yellow

$redisRunning = docker ps --filter "name=redis" --filter "status=running" --format "{{.Names}}" | Select-String -Pattern "redis"

if ($redisRunning) {
    Write-Host "  ✅ Redis container is already running" -ForegroundColor Green
} else {
    # Check if container exists but is stopped
    $redisExists = docker ps -a --filter "name=redis" --format "{{.Names}}" | Select-String -Pattern "redis"
    
    if ($redisExists) {
        Write-Host "  ⚠️  Redis container exists but is stopped. Starting..." -ForegroundColor Yellow
        docker start redis
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  ✅ Redis container started" -ForegroundColor Green
        } else {
            Write-Host "  ❌ Failed to start Redis container" -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "  ⚠️  Redis container not found. Pulling and starting..." -ForegroundColor Yellow
        docker run -d --name redis -p 6379:6379 redis:latest
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  ✅ Redis container pulled and started" -ForegroundColor Green
        } else {
            Write-Host "  ❌ Failed to start Redis container" -ForegroundColor Red
            exit 1
        }
    }
}
Start-Sleep -Seconds 2

# Step 4: Install Frontend Dependencies
if (-not $SkipInstall) {
    Write-Host "`n[4/8] Installing frontend dependencies..." -ForegroundColor Yellow
    
    if (-not (Test-Path $FRONTEND_DIR)) {
        Write-Host "  ❌ Frontend directory not found: $FRONTEND_DIR" -ForegroundColor Red
        exit 1
    }
    
    Set-Location $FRONTEND_DIR
    
    if ($FirstRun -or -not (Test-Path "node_modules")) {
        Write-Host "  📦 Installing npm packages..." -ForegroundColor Cyan
        npm install
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  ❌ Failed to install frontend dependencies" -ForegroundColor Red
            Set-Location $ROOT_DIR
            exit 1
        }
        Write-Host "  ✅ Frontend dependencies installed" -ForegroundColor Green
    } else {
        Write-Host "  ✅ Frontend dependencies already installed (use -FirstRun to reinstall)" -ForegroundColor Green
    }
    
    Set-Location $ROOT_DIR
} else {
    Write-Host "`n[4/8] Skipping frontend dependency installation" -ForegroundColor Gray
}

# Step 5: Install Backend Dependencies
if (-not $SkipInstall) {
    Write-Host "`n[5/8] Installing backend dependencies..." -ForegroundColor Yellow
    
    if (-not (Test-Path $BACKEND_DIR)) {
        Write-Host "  ❌ Backend directory not found: $BACKEND_DIR" -ForegroundColor Red
        exit 1
    }
    
    Set-Location $BACKEND_DIR
    
    if (-not (Test-Path "venv")) {
        Write-Host "  📦 Creating Python virtual environment..." -ForegroundColor Cyan
        python -m venv venv
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  ❌ Failed to create virtual environment" -ForegroundColor Red
            Set-Location $ROOT_DIR
            exit 1
        }
    }
    
    if ($FirstRun -or -not (Test-Path "venv\Lib\site-packages\flask")) {
        Write-Host "  📦 Installing Python packages..." -ForegroundColor Cyan
        & "venv\Scripts\Activate.ps1"
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  ❌ Failed to install backend dependencies" -ForegroundColor Red
            deactivate
            Set-Location $ROOT_DIR
            exit 1
        }
        deactivate
        Write-Host "  ✅ Backend dependencies installed" -ForegroundColor Green
    } else {
        Write-Host "  ✅ Backend dependencies already installed (use -FirstRun to reinstall)" -ForegroundColor Green
    }
    
    Set-Location $ROOT_DIR
} else {
    Write-Host "`n[5/8] Skipping backend dependency installation" -ForegroundColor Gray
}

# Step 6: Clean up Celery Beat schedule files (Windows compatibility fix)
Write-Host "`n[6/8] Cleaning Celery Beat schedule files..." -ForegroundColor Yellow

Set-Location $BACKEND_DIR

$celeryFiles = @("celerybeat-schedule", "celerybeat-schedule-shm", "celerybeat-schedule-wal", "celerybeat-schedule.db")
$cleanedFiles = 0

foreach ($file in $celeryFiles) {
    if (Test-Path $file) {
        try {
            Remove-Item $file -Force
            $cleanedFiles++
        } catch {
            Write-Host "  ⚠️  Could not delete $file (may be in use)" -ForegroundColor Yellow
        }
    }
}

if ($cleanedFiles -gt 0) {
    Write-Host "  ✅ Cleaned $cleanedFiles Celery Beat schedule file(s)" -ForegroundColor Green
} else {
    Write-Host "  ✅ No Celery Beat schedule files to clean" -ForegroundColor Green
}

Set-Location $ROOT_DIR

# Step 7: Check if ports are available
Write-Host "`n[7/8] Checking port availability..." -ForegroundColor Yellow

$ports = @{
    "5000" = "Flask Backend"
    "8080" = "Vue Frontend"
    "6379" = "Redis"
}

$portsInUse = @()

foreach ($port in $ports.Keys) {
    if (Test-PortInUse $port) {
        $service = $ports[$port]
        Write-Host "  ⚠️  Port $port is in use ($service)" -ForegroundColor Yellow
        $portsInUse += $port
    } else {
        Write-Host "  ✅ Port $port is available ($($ports[$port]))" -ForegroundColor Green
    }
}

if ($portsInUse.Count -gt 0 -and $portsInUse -notcontains "6379") {
    Write-Host "`n  ⚠️  Warning: Some ports are in use. Services may fail to start." -ForegroundColor Yellow
    Write-Host "  💡 Tip: Close applications using these ports or they will be reused." -ForegroundColor Cyan
}

# Step 8: Start all services in VS Code terminals
Write-Host "`n[8/8] Starting development servers in VS Code terminals..." -ForegroundColor Yellow
Write-Host ""

$isVSCode = $env:TERM_PROGRAM -eq "vscode" -or $env:VSCODE_PID

if (-not $isVSCode) {
    Write-Host "⚠️  Not running in VS Code. Opening terminals in VS Code..." -ForegroundColor Yellow
    
    $commandsFile = Join-Path $ROOT_DIR ".vscode-terminal-commands.json"
    
    $commands = @{
        terminals = @(
            @{
                name = "Frontend"
                cwd = $FRONTEND_DIR
                commands = @(
                    "Write-Host '🎨 Frontend Server (Vue)' -ForegroundColor Magenta",
                    "npm run serve"
                )
            },
            @{
                name = "Backend"
                cwd = $BACKEND_DIR
                commands = @(
                    "& 'venv\Scripts\Activate.ps1'",
                    "Write-Host '🔧 Flask Backend Server' -ForegroundColor Blue",
                    "python app.py"
                )
            },
            @{
                name = "Celery Worker"
                cwd = $BACKEND_DIR
                commands = @(
                    "& 'venv\Scripts\Activate.ps1'",
                    "Write-Host '⚙️  Celery Worker' -ForegroundColor Yellow",
                    "celery -A app.celery worker --pool=solo -l info"
                )
            },
            @{
                name = "Celery Beat"
                cwd = $BACKEND_DIR
                commands = @(
                    "& 'venv\Scripts\Activate.ps1'",
                    "Write-Host '⏰ Celery Beat Scheduler' -ForegroundColor Cyan",
                    "celery -A app.celery beat -l info --scheduler celery.beat:PersistentScheduler"
                )
            }
        )
    }
    
    $commands | ConvertTo-Json -Depth 10 | Set-Content $commandsFile
    
    Write-Host "📝 Creating VS Code tasks..." -ForegroundColor Cyan
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  ✅ Setup Complete!                   " -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "📱 To start the services:" -ForegroundColor Cyan
    Write-Host "  1. Open VS Code in this directory" -ForegroundColor White
    Write-Host "  2. Run this script from VS Code's integrated terminal" -ForegroundColor White
    Write-Host ""
    Write-Host "Or run these commands manually in VS Code terminals:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Terminal 1 (Frontend):" -ForegroundColor Magenta
    Write-Host "  cd frontend && npm run serve" -ForegroundColor White
    Write-Host ""
    Write-Host "Terminal 2 (Backend):" -ForegroundColor Blue
    Write-Host "  cd backend && .\venv\Scripts\Activate.ps1 && python app.py" -ForegroundColor White
    Write-Host ""
    Write-Host "Terminal 3 (Celery Worker):" -ForegroundColor Yellow
    Write-Host "  cd backend && .\venv\Scripts\Activate.ps1 && celery -A app.celery worker --pool=solo -l info" -ForegroundColor White
    Write-Host ""
    Write-Host "Terminal 4 (Celery Beat):" -ForegroundColor Cyan
    Write-Host "  cd backend && .\venv\Scripts\Activate.ps1 && celery -A app.celery beat -l info" -ForegroundColor White
    Write-Host ""
    
    exit 0
}

Write-Host "✅ Running in VS Code! Creating integrated terminals..." -ForegroundColor Green
Write-Host ""

$createTerminalsScript = @"
# Frontend Terminal
`$terminal1 = New-Object -ComObject "ConEmu.Interop.GuiMacro"
code --command "workbench.action.terminal.new"
Start-Sleep -Milliseconds 500
code --command "workbench.action.terminal.renameWithArg" --args '{\"name\":\"Frontend\"}'
Start-Sleep -Milliseconds 300
code --command "workbench.action.terminal.sendSequence" --args '{\"text\":\"cd frontend\r\nnpm run serve\r\"}'

# Backend Terminal
Start-Sleep -Milliseconds 800
code --command "workbench.action.terminal.new"
Start-Sleep -Milliseconds 500
code --command "workbench.action.terminal.renameWithArg" --args '{\"name\":\"Backend\"}'
Start-Sleep -Milliseconds 300
code --command "workbench.action.terminal.sendSequence" --args '{\"text\":\"cd backend\r\n.\\venv\\Scripts\\Activate.ps1\r\npython app.py\r\"}'

# Celery Worker Terminal
Start-Sleep -Milliseconds 800
code --command "workbench.action.terminal.new"
Start-Sleep -Milliseconds 500
code --command "workbench.action.terminal.renameWithArg" --args '{\"name\":\"Celery Worker\"}'
Start-Sleep -Milliseconds 300
code --command "workbench.action.terminal.sendSequence" --args '{\"text\":\"cd backend\r\n.\\venv\\Scripts\\Activate.ps1\r\ncelery -A app.celery worker --pool=solo -l info\r\"}'

# Celery Beat Terminal
Start-Sleep -Milliseconds 800
code --command "workbench.action.terminal.new"
Start-Sleep -Milliseconds 500
code --command "workbench.action.terminal.renameWithArg" --args '{\"name\":\"Celery Beat\"}'
Start-Sleep -Milliseconds 300
code --command "workbench.action.terminal.sendSequence" --args '{\"text\":\"cd backend\r\n.\\venv\\Scripts\\Activate.ps1\r\ncelery -A app.celery beat -l info\r\"}'
"@

# Since we can't directly create VS Code terminals from PowerShell,
# we'll provide instructions and optionally create a tasks.json file
Write-Host "Creating VS Code tasks configuration..." -ForegroundColor Cyan

$vscodeDir = Join-Path $ROOT_DIR ".vscode"
if (-not (Test-Path $vscodeDir)) {
    New-Item -ItemType Directory -Path $vscodeDir | Out-Null
}

$tasksJson = @"
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Start Frontend",
            "type": "shell",
            "command": "npm run serve",
            "options": {
                "cwd": "`${workspaceFolder}/frontend"
            },
            "isBackground": true,
            "problemMatcher": [],
            "presentation": {
                "group": "dev-servers",
                "panel": "dedicated",
                "reveal": "always"
            }
        },
        {
            "label": "Start Backend",
            "type": "shell",
            "command": ".\\venv\\Scripts\\Activate.ps1; python app.py",
            "options": {
                "cwd": "`${workspaceFolder}/backend"
            },
            "isBackground": true,
            "problemMatcher": [],
            "presentation": {
                "group": "dev-servers",
                "panel": "dedicated",
                "reveal": "always"
            }
        },
        {
            "label": "Start Celery Worker",
            "type": "shell",
            "command": ".\\venv\\Scripts\\Activate.ps1; celery -A app.celery worker --pool=solo -l info",
            "options": {
                "cwd": "`${workspaceFolder}/backend"
            },
            "isBackground": true,
            "problemMatcher": [],
            "presentation": {
                "group": "dev-servers",
                "panel": "dedicated",
                "reveal": "always"
            }
        },
        {
            "label": "Start Celery Beat",
            "type": "shell",
            "command": ".\\venv\\Scripts\\Activate.ps1; celery -A app.celery beat -l info",
            "options": {
                "cwd": "`${workspaceFolder}/backend"
            },
            "isBackground": true,
            "problemMatcher": [],
            "presentation": {
                "group": "dev-servers",
                "panel": "dedicated",
                "reveal": "always"
            }
        },
        {
            "label": "Start All Services",
            "dependsOn": [
                "Start Frontend",
                "Start Backend",
                "Start Celery Worker",
                "Start Celery Beat"
            ],
            "problemMatcher": []
        }
    ]
}
"@

$tasksFile = Join-Path $vscodeDir "tasks.json"
$tasksJson | Set-Content $tasksFile

Write-Host "✅ VS Code tasks.json created!" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  🎉 Setup Complete!                   " -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "📱 To start all services in VS Code terminals:" -ForegroundColor Cyan
Write-Host ""
Write-Host "Option 1 - Use Tasks (Recommended):" -ForegroundColor Yellow
Write-Host "  1. Press Ctrl+Shift+P" -ForegroundColor White
Write-Host "  2. Type 'Tasks: Run Task'" -ForegroundColor White
Write-Host "  3. Select 'Start All Services'" -ForegroundColor White
Write-Host ""
Write-Host "Option 2 - Manual Terminal Creation:" -ForegroundColor Yellow
Write-Host "  Create 4 new terminals and run these commands:" -ForegroundColor White
Write-Host ""
Write-Host "  Terminal 1 (Frontend): " -ForegroundColor Magenta -NoNewline
Write-Host "cd frontend && npm run serve" -ForegroundColor White
Write-Host "  Terminal 2 (Backend):  " -ForegroundColor Blue -NoNewline
Write-Host "cd backend && .\venv\Scripts\Activate.ps1 && python app.py" -ForegroundColor White
Write-Host "  Terminal 3 (Celery W): " -ForegroundColor Yellow -NoNewline
Write-Host "cd backend && .\venv\Scripts\Activate.ps1 && celery -A app.celery worker --pool=solo -l info" -ForegroundColor White
Write-Host "  Terminal 4 (Celery B): " -ForegroundColor Cyan -NoNewline
Write-Host "cd backend && .\venv\Scripts\Activate.ps1 && celery -A app.celery beat -l info" -ForegroundColor White
Write-Host ""
Write-Host "📱 Application URLs:" -ForegroundColor Cyan
Write-Host "  Frontend:  http://localhost:8080" -ForegroundColor White
Write-Host "  Backend:   http://localhost:5000" -ForegroundColor White
Write-Host "  Redis:     localhost:6379" -ForegroundColor White
Write-Host ""
