# Changelog

## [v2.0.3](https://github.com/defra/defra-ruby-area/tree/v2.0.3) (2022-03-03)

[Full Changelog](https://github.com/defra/defra-ruby-area/compare/v2.0.2...v2.0.3)

**Merged pull requests:**

- Upgrade nokogiri in response to security alerts [\#35](https://github.com/DEFRA/defra-ruby-area/pull/35) ([tobyprivett](https://github.com/tobyprivett))

## [v2.0.2](https://github.com/defra/defra-ruby-area/tree/v2.0.2) (2021-09-30)

[Full Changelog](https://github.com/defra/defra-ruby-area/compare/v2.0.1...v2.0.2)

**Merged pull requests:**

- Update nokogiri requirement from ~\> 1.11.1 to \>= 1.11.1, \< 1.13.0 [\#33](https://github.com/DEFRA/defra-ruby-area/pull/33) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v2.0.1](https://github.com/defra/defra-ruby-area/tree/v2.0.1) (2021-02-12)

[Full Changelog](https://github.com/defra/defra-ruby-area/compare/v2.0.0...v2.0.1)

**Merged pull requests:**

- Update allowed Nokogiri version [\#32](https://github.com/DEFRA/defra-ruby-area/pull/32) ([irisfaraway](https://github.com/irisfaraway))
- Update nokogiri requirement from ~\> 1.10.9 to \>= 1.10.9, \< 1.12.0 [\#31](https://github.com/DEFRA/defra-ruby-area/pull/31) ([dependabot[bot]](https://github.com/apps/dependabot))
- Switch from Travis CI to GitHub Actions [\#30](https://github.com/DEFRA/defra-ruby-area/pull/30) ([irisfaraway](https://github.com/irisfaraway))
- Create Dependabot config file [\#29](https://github.com/DEFRA/defra-ruby-area/pull/29) ([dependabot-preview[bot]](https://github.com/apps/dependabot-preview))
- Fix issue in travis with bundler args [\#25](https://github.com/DEFRA/defra-ruby-area/pull/25) ([Cruikshanks](https://github.com/Cruikshanks))
- Remove VCR and use Webmock instead [\#24](https://github.com/DEFRA/defra-ruby-area/pull/24) ([irisfaraway](https://github.com/irisfaraway))
- Use multiple rubocop formats in Travis build [\#23](https://github.com/DEFRA/defra-ruby-area/pull/23) ([Cruikshanks](https://github.com/Cruikshanks))
- Switch to SonarCloud from CodeClimate [\#22](https://github.com/DEFRA/defra-ruby-area/pull/22) ([Cruikshanks](https://github.com/Cruikshanks))
- Fix bin/console and use pry instead of irb [\#20](https://github.com/DEFRA/defra-ruby-area/pull/20) ([Cruikshanks](https://github.com/Cruikshanks))
- Fix changelog generator [\#19](https://github.com/DEFRA/defra-ruby-area/pull/19) ([Cruikshanks](https://github.com/Cruikshanks))
- Update VCR cassettes [\#18](https://github.com/DEFRA/defra-ruby-area/pull/18) ([Cruikshanks](https://github.com/Cruikshanks))
- Temp. fix for cc-test-reporter & SimpleCov 0.18 [\#17](https://github.com/DEFRA/defra-ruby-area/pull/17) ([Cruikshanks](https://github.com/Cruikshanks))
- Update vcr requirement from ~\> 4.0 to ~\> 5.0 [\#16](https://github.com/DEFRA/defra-ruby-area/pull/16) ([dependabot-preview[bot]](https://github.com/apps/dependabot-preview))
- Update VCR test cassettes [\#15](https://github.com/DEFRA/defra-ruby-area/pull/15) ([Cruikshanks](https://github.com/Cruikshanks))
- Fix security issue with Nokogiri [\#14](https://github.com/DEFRA/defra-ruby-area/pull/14) ([Cruikshanks](https://github.com/Cruikshanks))
- Fix rubocop issues following update [\#13](https://github.com/DEFRA/defra-ruby-area/pull/13) ([Cruikshanks](https://github.com/Cruikshanks))
- Update VCR Cassettes [\#12](https://github.com/DEFRA/defra-ruby-area/pull/12) ([Cruikshanks](https://github.com/Cruikshanks))

## [v2.0.0](https://github.com/defra/defra-ruby-area/tree/v2.0.0) (2019-08-29)

[Full Changelog](https://github.com/defra/defra-ruby-area/compare/v1.1.0...v2.0.0)

**Fixed bugs:**

- Update minimum Nokogiri version to 1.10.4 [\#11](https://github.com/DEFRA/defra-ruby-area/pull/11) ([Cruikshanks](https://github.com/Cruikshanks))

**Merged pull requests:**

- Add support for multiple WFS results [\#10](https://github.com/DEFRA/defra-ruby-area/pull/10) ([Cruikshanks](https://github.com/Cruikshanks))

## [v1.1.0](https://github.com/defra/defra-ruby-area/tree/v1.1.0) (2019-08-11)

[Full Changelog](https://github.com/defra/defra-ruby-area/compare/v1.0.0...v1.1.0)

**Implemented enhancements:**

- Add area name to WFS request and response [\#9](https://github.com/DEFRA/defra-ruby-area/pull/9) ([Cruikshanks](https://github.com/Cruikshanks))
- Add area ID to WFS request [\#7](https://github.com/DEFRA/defra-ruby-area/pull/7) ([Cruikshanks](https://github.com/Cruikshanks))

**Merged pull requests:**

- Refactor Area to parse the WFS XML response [\#8](https://github.com/DEFRA/defra-ruby-area/pull/8) ([Cruikshanks](https://github.com/Cruikshanks))

## [v1.0.0](https://github.com/defra/defra-ruby-area/tree/v1.0.0) (2019-08-10)

[Full Changelog](https://github.com/defra/defra-ruby-area/compare/v0.2.1...v1.0.0)

**Implemented enhancements:**

- Extract code and short name from WFS's [\#6](https://github.com/DEFRA/defra-ruby-area/pull/6) ([Cruikshanks](https://github.com/Cruikshanks))

## [v0.2.1](https://github.com/defra/defra-ruby-area/tree/v0.2.1) (2019-08-06)

[Full Changelog](https://github.com/defra/defra-ruby-area/compare/v0.2.0...v0.2.1)

**Fixed bugs:**

- Resolve hakiri security warning for nokogiri [\#3](https://github.com/DEFRA/defra-ruby-area/pull/3) ([Cruikshanks](https://github.com/Cruikshanks))

**Merged pull requests:**

- Breakdown url\(\) in services for readability [\#5](https://github.com/DEFRA/defra-ruby-area/pull/5) ([Cruikshanks](https://github.com/Cruikshanks))
- Remove unnecessary rescue in base\_service [\#4](https://github.com/DEFRA/defra-ruby-area/pull/4) ([Cruikshanks](https://github.com/Cruikshanks))

## [v0.2.0](https://github.com/defra/defra-ruby-area/tree/v0.2.0) (2019-08-05)

[Full Changelog](https://github.com/defra/defra-ruby-area/compare/v0.1.0...v0.2.0)

**Implemented enhancements:**

- Add timeout configuration option [\#2](https://github.com/DEFRA/defra-ruby-area/pull/2) ([Cruikshanks](https://github.com/Cruikshanks))

## [v0.1.0](https://github.com/defra/defra-ruby-area/tree/v0.1.0) (2019-08-03)

[Full Changelog](https://github.com/defra/defra-ruby-area/compare/124ee13db1dc24c95f7503a96ec4cb9f1271862c...v0.1.0)

**Implemented enhancements:**

- Setup project with CI services [\#1](https://github.com/DEFRA/defra-ruby-area/pull/1) ([Cruikshanks](https://github.com/Cruikshanks))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
