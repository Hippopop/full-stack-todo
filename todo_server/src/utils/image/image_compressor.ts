import sharp from 'sharp';
import fs, { PathLike } from 'fs';

const _getFileSizeInMB = (filePath: PathLike) => {
    const stats = fs.statSync(filePath);
    return stats.size / (1024 * 1024);
};

const _getBufferSizeInMB = (buffer: Buffer) => {
    return buffer.byteLength / 1000000;
}

/* async function compressImageToTargetSize(inputPath: PathLike, targetSizeMB: number): Promise<String> {
    let initialQuality = 80;
    const maxIterations = 3;
    const currentPath = inputPath.toString();
    const typeSplit = currentPath.split('.');
    const type = typeSplit[typeSplit.length - 1]!;
    const outputPath = currentPath.replace(type, 'webp.temp');
    const finalPath = currentPath.replace(type, 'webp');

    let iteration = 0;
    while (iteration < maxIterations) {
        await sharp(inputPath.toString())
            .webp({ quality: initialQuality })
            .toFile(outputPath.toString());

        const fileSizeMB = _getFileSizeInMB(outputPath);
        if (fileSizeMB <= targetSizeMB) {
            console.log(`Image compressed successfully to ${fileSizeMB.toFixed(2)} MB`);
            break;
        }
        initialQuality = Math.max(1, (targetSizeMB * 100) / fileSizeMB);
        iteration++;
    }

    fs.unlink(inputPath, (err) => {
        if (err) { console.log(`Error deleting original file: ${err}`) } else {
            fs.rename(outputPath, finalPath, (err) => { if (err) { console.log(`Error renaming file: ${err}`) } });
        }
    });

    if (iteration === maxIterations) {
        console.log('Reached maximum iterations, the target size might not be met.');
    }
    return outputPath;
} */

async function compressImageBufferToWebp(imageName: string, buffer: Buffer, targetSizeMB: number): Promise<Buffer> {
    let finalBuffer = await sharp(buffer).metadata().then(({ width, height }) => {
        return sharp(buffer)
            .rotate()
            .resize(Math.round((width ?? 450) * 0.5), Math.round((height ?? 450) * 0.5))
            .webp({ force: true, })
            .toBuffer();
    });
    let bufferSize = _getBufferSizeInMB(finalBuffer);

    const maxIterations = 3;
    let iteration = 0;

    while (iteration < maxIterations && bufferSize > targetSizeMB) {
        finalBuffer = await sharp(finalBuffer).metadata().then(({ width, height }) => {
            return sharp(finalBuffer)
                .rotate()
                .resize(Math.round((width ?? 450) * 0.5), Math.round((height ?? 450) * 0.5))
                .webp({ quality: Math.ceil(Math.max(1, (targetSizeMB * 100) / bufferSize)), force: true, })
                .toBuffer();
        });

        bufferSize = _getBufferSizeInMB(finalBuffer);
        console.log(`Buffer size: ${bufferSize.toFixed(2)} MB`);
        iteration++;
    };
    if (iteration === maxIterations) {
        console.log('Reached maximum iterations, the target size might not be met.');
        console.log(`Image compressed successfully to ${bufferSize.toFixed(2)} MB`);
    }
    return finalBuffer;
}

export { compressImageBufferToWebp }

