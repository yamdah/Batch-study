@echo off
rem **************************
rem * ファイルバックアップ   *
rem **************************
rem * BK     test1 > test2   *
rem **************************

:start / 開始
	cd /d %~dp0
	setlocal enabledelayedexpansion
	openfiles > nul
	if %errorlevel% neq 0 (
		echo %date% %time% 失敗 管理者権限がありません
		goto exception
	)

:first / 環境変数設定
	if exist C:\test\batch\Env.bat (
		call Env.bat 
		if %errorlevel% neq 0 (
			echo %date% %time% 失敗 ファイル読込
			goto exception
		)
		echo %date% %time% 成功 ファイル読込終了
	) else (
		echo %date% %time% 失敗 ファイルなし
		goto exception
	)

:second / 作業前クリーニング
	cd /d C:\test\folder2
	if exist %pW%\performance\* (
		del /q %pW%\performance\*
		if exist %pW%\performance\*.log (
			echo %date% %time% 失敗 作業前クリーニング1
			goto exception
		) else (
			echo %date% %time% 成功 作業前クリーニング1終了
		)
	) else (
		echo %date% %time% 作業前クリーニング1 対象ファイルなし
	)

:third / ファイルコピー
	cd /d C:\test\folder1
	for /f %%c in ('dir /a-d /b performance_*.log ^| find /c /v ""') do set count1=%%c
	if not %count1%==0 (
		for /f %%f in ('dir /b /on performance_*.log') do set file1=%%f
		copy /y !file1! %pW%\performance
		if %errorlevel% neq 0 (
			echo %date% %time% 失敗 コピー1
			goto exception
		) else (
			echo %date% %time% 成功 コピー1終了
		)
	) else (
		echo %date% %time% コピー1 対象ファイルなし
	)

:forth / ファイル圧縮
	cd /d %pW%\performance
	for /f %%c in ('dir /a-d /b performance_*.log ^| find /c /v ""') do set count1=%%c
	if not %count1%==0 (
		echo ここで圧縮する
		if %errorlevel% neq 0 (
			echo %date% %time% 失敗 圧縮1
			goto exception
		) else (
			echo %date% %time% 成功 圧縮1終了
		)
	)

:fifth / 出力フォルダクリーニング
	cd /d %pO%
	for /f "skip=5" %%f in ('dir /b /o-n performance_*.log') do (
		del /q %%f
		if not exist %%f (
			echo %date% %time% 成功 出力フォルダクリーニング1終了 %%f
		) else (
			echo %date% %time% 失敗 出力フォルダクリーニング1
			goto exception
		)
	)

:sixth / 保管フォルダクリーニング
	cd /d %pB%
	if exist performance_*.zip (
		for /f "skip=10" %%f in ('dir /b /o-n performance_*.zip') do (
			del /q %%f
			if exist %%f (
				echo %date% %time% 失敗 保管フォルダクリーニング1 %%f
				goto exception
			) else (
				echo %date% %time% 成功 保管フォルダクリーニング1終了 %%f
		)
	)

:normal / 正常
	echo %date% %time% 正常終了
	goto end

:exception / 異常
	echo %date% %time% 異常終了

:end / 終了
	cd /d C:\test\batch
	exit /b
