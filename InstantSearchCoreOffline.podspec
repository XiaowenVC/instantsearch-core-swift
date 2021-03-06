Pod::Spec.new do |s|
    # Pod metadata
    # ------------
    s.name = 'InstantSearchCoreOffline'
    s.module_name = 'InstantSearchCore'
    s.version = '3.3.0'
    s.license = 'MIT'
    s.summary = 'Instant Search library for Swift by Algolia'
    s.homepage = 'https://github.com/algolia/instantsearch-core-swift'
    s.author   = { 'Algolia' => 'contact@algolia.com' }
    s.source = { :git => 'https://github.com/algolia/instantsearch-core-swift.git', :tag => s.version }

    # Build settings
    # --------------
    # NOTE: Deployment targets should be kept in line with the API Client.
    s.ios.deployment_target = '8.0'

    s.source_files = [
        'Sources/*.swift'
    ]

    # Dependencies
    # ------------
    s.dependency 'InstantSearchClientOffline', '~> 5.0'
end
