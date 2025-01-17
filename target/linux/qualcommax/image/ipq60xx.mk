define Device/FitImage
	KERNEL_SUFFIX := -uImage.itb
	KERNEL = kernel-bin | libdeflate-gzip | fit gzip $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef

define Device/FitImageLzma
	KERNEL_SUFFIX := -uImage.itb
	KERNEL = kernel-bin | lzma | fit lzma $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef

define Device/UbiFit
	KERNEL_IN_UBI := 1
	IMAGES := factory.ubi sysupgrade.bin
	IMAGE/factory.ubi := append-ubi
	IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
endef

define Device/linksys_mr7350
	$(call Device/FitImage)
	DEVICE_VENDOR := Linksys
	DEVICE_MODEL := MR7350
	SOC := ipq6000
	KERNEL_SIZE := 8192k
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	UBINIZE_OPTS := -E 5
	IMAGES += factory.bin
	IMAGE/factory.bin := append-kernel | pad-to $$$$(KERNEL_SIZE) | \
		append-ubi | linksys-image type=MR7350
	DEVICE_PACKAGES := ipq-wifi-linksys_mr7350 \
		kmod-leds-pca963x kmod-usb-ledtrig-usbport
endef
TARGET_DEVICES += linksys_mr7350

define Device/qihoo_360v6
	$(call Device/FitImage)
	$(call Device/UbiFit)
	DEVICE_VENDOR := Qihoo
	DEVICE_MODEL := 360V6
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	SOC := ipq6000
	DEVICE_DTS_CONFIG := config@cp03-c1
	DEVICE_PACKAGES := ipq-wifi-qihoo_360v6
endef
TARGET_DEVICES += qihoo_360v6
