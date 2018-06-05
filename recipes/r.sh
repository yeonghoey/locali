brew bundle --verbose --file=<(cat <<EOF

tap 'caskroom/cask'
brew 'r'
cask 'rstudio'

EOF
)

defaults write org.R-project.R force.LANG 'en_US.UTF-8'

readonly PACKAGES=(
  '"ggplot2"'
  '"rmarkdown"'
  '"mlbench"'
  '"ISLR"'
)

readonly PKGS="c($(IFS=','; echo "${PACKAGES[*]}"))"
R -e "install.packages(${PKGS}, repos = 'https://cran.rstudio.com')"
