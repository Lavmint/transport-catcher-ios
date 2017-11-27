//
//  DGSTileOverlay.swift
//  iOS-SDKs-for-tiles https://github.com/2gis/iOS-SDKs-for-tiles
//
//  Created by kriogen https://github.com/kriogen on 25/06/2017.
//  Copyright © 2017 kriogen. All rights reserved.
//

import MapKit

internal class DGSTileOverlay: MKTileOverlay {

	private let isRetina: Bool
	private let cache = NSCache<NSURL, NSData>()
	private let urlSession = URLSession(configuration: URLSessionConfiguration.default)

	override public func url(forTilePath path: MKTileOverlayPath) -> URL {
        let format = isRetina ? "https://rtile2.maps.2gis.com/tiles?x=%d&y=%d&z=%d&v=1" : "https://tile2.maps.2gis.com/tiles?x=%d&y=%d&z=%d&v=1"
        guard let url = URL(string: String(format: format, path.x, path.y, path.z)) else {
            assertionFailure()
            return super.url(forTilePath: path)
        }
        return url
	}

	internal init(isRetina: Bool = true) {
		self.isRetina = isRetina
		super.init(urlTemplate: nil)
        self.tileSize = isRetina ? CGSize(width: 512, height: 512) : CGSize(width: 256, height: 256)
		self.canReplaceMapContent = true
		self.maximumZ = 18
	}

	override public func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void) {
		let url = self.url(forTilePath: path)
		if let cachedData = self.cache.object(forKey: url as NSURL) as Data? {
			result(cachedData, nil)
		} else {
			let task = self.urlSession.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                guard let data = data else { return }
                self?.cache.setObject(data as NSData, forKey: url as NSURL)
				result(data, error)
			})
			task.resume()
		}
	}
}