## 🚀 AndFactory-iOS
- Githubのユーザーを検索し、一覧からユーザーの詳細画面を表示するアプリです。

<img width="526" alt="スクリーンショット 2020-02-28 12 08 21" src="https://user-images.githubusercontent.com/38596913/75507031-2fc4c000-5a23-11ea-825d-3279544afa3c.png">

## 📖 ライブラリ管理
- Carthage version: 0.34.0 

## 🧑‍💻設計
- MVC

## 🏋️導入方法
```
carthage update --platform iOS
```

## API
- ドキュメント
https://developer.github.com/v3/search/#search-users
``` 
GET https://api.github.com/search/users?q=[username]

```

## ⚠️注意事項
- GithubAPIは1分間に10回リクエストをするとレート制限がかかり、503エラーになります。
