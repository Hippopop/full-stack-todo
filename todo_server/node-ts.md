# TypeScript Setup For NodeJs &copy;Mostafij

## 1. **`Typescript`** setup

1. `npm init` For initializing **NodeJs** in the directory!
2. `npm i ts-node -D` Add the **TypeScript** compiler/converter as a development dependency for converting everything from `.ts` to `.js`.
3. Then make sure to add **Typescript** implementations for all your `packages` to the dev dependency. In most cases you just have to run this command `npm i --save-dev @types/your_package_name`. </br>
(*example: `npm i --save-dev @types/express`*).
</br>

## 2. **`Nodemon`** setup

There are two ways to configure **Nodemon** inside your project.

- With a command setup inside `package.json/.scripts`.</br>
Run this command in one of your `scripts` *(most probably as `dev`)*</br>
`nodemon --watch \"src/**\" --ext \"ts,json\" --ignore \"src/**/*.spec.ts\" --exec \"ts-node src/index.ts\"`

- With a `nodemon.json` config file.</br>
Or create a file named `nodemon.json` inside the root directory of your project. And set the same config in `.json` format.

```json
{
  "watch": ["src"], //Main directory to watch.
  "ext": "ts,json", //File extensions to watch.
  "ignore": ["src/**/*.spec.ts"], //File extensions to ignore.
  "exec": "ts-node ./src/index.ts" // or "npx ts-node src/index.ts" to execute the conversion.
}
```

</br>For deploying and configuring the conversion procedure, follow this [\*tutorial\*](https://youtu.be/H91aqUHn8sE) from `Beyond Fireship`.
