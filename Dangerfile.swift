
import Danger
let danger = Danger()

print("Running Swiftlint on changed files...")
SwiftLint.lint(inline: true, strict: true)
