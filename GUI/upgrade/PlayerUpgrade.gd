extends Control

func _ready():
	match Globals.currentAge:
		0:
			$UpgradePanel/UpgradeLabel/UnlockPanel/TimeEra.text = "CURRENT AGE: STONE (ZERO)"
		1:
			$UpgradePanel/UpgradeLabel/UnlockPanel/TimeEra.text = "CURRENT AGE: MEDIEVAL (ONE)"
		2:
			$UpgradePanel/UpgradeLabel/UnlockPanel/TimeEra.text = "CURRENT AGE: CLASSICAL (TWO)"
		3:
			$UpgradePanel/UpgradeLabel/UnlockPanel/TimeEra.text = "CURRENT AGE: MODERN (THREE)"

func _process(delta):
	match Globals.currentAge:
		0:
			$UpgradePanel/UpgradeLabel/UnlockPanel/TimeEra.text = "CURRENT AGE: STONE (ZERO)"
		1:
			$UpgradePanel/UpgradeLabel/UnlockPanel/TimeEra.text = "CURRENT AGE: MEDIEVAL (ONE)"
		2:
			$UpgradePanel/UpgradeLabel/UnlockPanel/TimeEra.text = "CURRENT AGE: CLASSICAL (TWO)"
		3:
			$UpgradePanel/UpgradeLabel/UnlockPanel/TimeEra.text = "CURRENT AGE: MODERN (THREE)"
