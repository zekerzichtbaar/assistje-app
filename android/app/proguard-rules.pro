# R8-regels voor de release-build (android/app/build.gradle.kts).
#
# Flutter en de plugins leveren hun eigen consumer-regels mee; hier alleen wat
# daarbuiten nodig is.

# Flutter verwijst naar Play Core (deferred components), dat we niet
# gebruiken: niet laten falen op die ontbrekende klassen.
-dontwarn com.google.android.play.core.**
