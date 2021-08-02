# Declalertive

_Declalertive_ helps control `UIAlertController`s declaratively.

```swift
import UIKit
import Combine
import Declalertive

class ViewController: UIViewController {
    final class State: ObservableObject {
        @Published var presentsAlert: Bool = false
    }

    private let state: State = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Makes a `UIAlertController` instance
        let alertController: UIAlertController = .init(title: "Title", message: "Message", preferredStyle: .alert)
        alertController.addAction(.init(title: "Cancel", style: .cancel) { [weak self] _ in
            print("Cancel")
            self?.state.presentsAlert = false
        })
        alertController.addAction(.init(title: "OK", style: .default) { [weak self] _ in
            print("OK")
            self?.state.presentsAlert = false
        })

        state
            .objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                // Control the `UIAlertController`'s presentations 
                self.setPresents(self.state.presentsAlert, alertController: alertController, animated: true)
            }
            .store(in: &cancellables)
    }
}
```

## License

MIT
