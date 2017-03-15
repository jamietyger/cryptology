function watermark(cipher,plaintext,covertext,sz,R)
    code=cipher; %Cipher = 1234
    pt = imread(plaintext); %Read plaintext
    ct = imread(covertext); % Read Covertext
    pt = im2double(pt);
    ct = im2double(ct);
    pt = 1-pt; %watermark
    size = size(pt,1) %Get Size
    rand(’state’,code); %Generate Random
    noise = rand(size,size); %Noise Creation
    %Display
    subplot(2,3,1),imshow(pt);
    subplot(2,3,2),imshow(ct);
    subplot(2,3,3),imshow(noise);
    cipher = fft2(noise); %Compute spectrum of cipher
    plaintext = fft2(pt); %Compute the spectrum of plaintext
    powerspectrum = abs(noise).^2; %Compute Power Spectrum
    for i=1:size %Preconditon power spectrum of cipher
        for j=1:size
            temp=powerspectrum(i,j);
            if temp==0
                powerspectrum(i,j)=1;
            else
                powerspectrum(i,j)=powerspectrum(i,j);
            end
        end
    end
    %Diffuse plaintext image with pre-conditioned cipher
    plaintext = plaintext(:,:,1);
    plaintext=cipher.*plaintext./powerspectrum;
    plaintext = ifft2(plaintext);
    plaintext = real(plaintext); %Compute real part of IFFT
    plaintext = plaintext./max(max(plaintext)); %Normalise diffusion
    subplot(2,3,4),imshow(plaintext,[min(min(plaintext)) max(max(plaintext))])
    %Compute Watermark
    covertext = ct(:,:,1);
    watermark = R*plaintext+covertext;
    subplot(2,3,5), imshow(watermark)
    %Subtract covertext from watermaked image
    diffusion = watermark - plaintext;
    diffusion = diffusion./max(max(plaintext)); %normalize
    plaintext = diffusion;
    plaintext=fft2(plaintext); %compute spectrum of diffusion field
    rand(’state’,code);
    cnoise = rand(size,size);
    cnoise = fft2(cnoise); %compute spectrum of cipher
    plaintext = conj(cnoise).*plaintext; %correlate diffused field with cipher
    plaintext=ifft2(plaintext);
    plaintext = real(plaintext) %compute real part of IFT
    plaintext=plaintext./max(max(plaintext)); %normalize
    subplot(2,3,6),imshow(plaintext,[min(min(plaintext)) max(max(plaintext))]) %display
